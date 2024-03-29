# Copyright 2010-2012 Wincent Colaiuta. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.

require 'command-t/finder/buffer_finder'
require 'command-t/finder/jump_finder'
require 'command-t/finder/file_finder'
require 'command-t/finder/tag_finder'
require 'command-t/match_window'
require 'command-t/prompt'
require 'command-t/vim/path_utilities'

module CommandT
  class Controller
    include VIM::PathUtilities

    def initialize
      @prompt = Prompt.new
    end

    def show_buffer_finder
      @path          = VIM::pwd
      @active_finder = buffer_finder
      show
    end

    def show_jump_finder
      @path          = VIM::pwd
      @active_finder = jump_finder
      show
    end

    def show_tag_finder
      @path          = VIM::pwd
      @active_finder = tag_finder
      show
    end

    def show_file_finderruby1.9.1
      # optional parameter will be desired starting directory, or ""
      @path             = File.expand_path(::VIM::evaluate('a:arg'), VIM::pwd)
      @active_finder    = file_finder
      file_finder.path  = @path
      show
    rescue Errno::ENOENT
      # probably a problem with the optional parameter
      @match_window.print_no_such_file_or_directory
    end

    def hide
      @match_window.close
      if VIM::Window.select @initial_window
        if @initial_buffer.number == 0
          # upstream bug: buffer number misreported as 0
          # see: https://wincent.com/issues/1617
          ::VIM::command "silent b #{@initial_buffer.name}"
        else
          ::VIM::command "silent b #{@initial_buffer.number}"
        end
      end
    end

    def refresh
      return unless @active_finder && @active_finder.respond_to?(:flush)
      @active_finder.flush
      list_matches
    end

    def flush
      @max_height   = nil
      @min_height   = nil
      @file_finder  = nil
      @tag_finder   = nil
    end

    def handle_key
      key = ::VIM::evaluate('a:arg').to_i.chr
      if @focus == @prompt
        @prompt.add! key
        list_matches
      else
        @match_window.find key
      end
    end

    def backspace
      if @focus == @prompt
        @prompt.backspace!
        list_matches
      end
    end

    def delete
      if @focus == @prompt
        @prompt.delete!
        list_matches
      end
    end

    def accept_selection options = {}
      selection = @match_window.selection
      hide
      open_selection(selection, options) unless selection.nil?
    end

    def toggle_focus
      @focus.unfocus # old focus
      @focus = @focus == @prompt ? @match_window : @prompt
      @focus.focus # new focus
    end

    def cancel
      hide
    end

    def select_next
      @match_window.select_next
    end

    def select_prev
      @match_window.select_prev
    end

    def clear
      @prompt.clear!
      list_matches
    end

    def cursor_left
      @prompt.cursor_left if @focus == @prompt
    end

    def cursor_right
      @prompt.cursor_right if @focus == @prompt
    end

    def cursor_end
      @prompt.cursor_end if @focus == @prompt
    end

    def cursor_start
      @prompt.cursor_start if @focus == @prompt
    end

    def leave
      @match_window.leave
    end

    def unload
      @match_window.unload
    end

  private

    def show
      @initial_window   = $curwin
      @initial_buffer   = $curbuf
      @match_window     = MatchWindow.new \
        :prompt               => @prompt,
        :match_window_at_top  => get_bool('g:CommandTMatchWindowAtTop'),
        :match_window_reverse => get_bool('g:CommandTMatchWindowReverse'),
        :min_height           => min_height
      @focus            = @prompt
      @prompt.focus
      register_for_key_presses
      clear # clears prompt and lists matches
    end

    def max_height
      @max_height ||= get_number('g:CommandTMaxHeight') || 0
    end

    def min_height
      @min_height ||= begin
        min_height = get_number('g:CommandTMinHeight') || 0
        min_height = max_height if max_height != 0 && min_height > max_height
        min_height
      end
    end

    def get_number name
      VIM::exists?(name) ? ::VIM::evaluate("#{name}").to_i : nil
    end

    def get_bool name
      VIM::exists?(name) ? ::VIM::evaluate("#{name}").to_i != 0 : nil
    end

    def get_string name
      VIM::exists?(name) ? ::VIM::evaluate("#{name}").to_s : nil
    end

    # expect a string or a list of strings
    def get_list_or_string name
      return nil unless VIM::exists?(name)
      list_or_string = ::VIM::evaluate("#{name}")
      if list_or_string.kind_of?(Array)
        list_or_string.map { |item| item.to_s }
      else
        list_or_string.to_s
      end
    end

    # Backslash-escape space, \, |, %, #, "
    def sanitize_path_string str
      # for details on escaping command-line mode arguments see: :h :
      # (that is, help on ":") in the Vim documentation.
      str.gsub(/[ \\|%#"]/, '\\\\\0')
    end

    def default_open_command
      if !get_bool('&hidden') && get_bool('&modified')
        'sp'
      else
        'e'
      end
    end

    def ensure_appropriate_window_selection
      # normally we try to open the selection in the current window, but there
      # is one exception:
      #
      # - we don't touch any "unlisted" buffer with buftype "nofile" (such as
      #   NERDTree or MiniBufExplorer); this is to avoid things like the "Not
      #   enough room" error which occurs when trying to open in a split in a
      #   shallow (potentially 1-line) buffer like MiniBufExplorer is current
      #
      # Other "unlisted" buffers, such as those with buftype "help" are treated
      # normally.
      initial = $curwin
      while true do
        break unless ::VIM::evaluate('&buflisted').to_i == 0 &&
          ::VIM::evaluate('&buftype').to_s == 'nofile'
        ::VIM::command 'wincmd w'     # try next window
        break if $curwin == initial # have already tried all
      end
    end

    def open_selection selection, options = {}
      command = options[:command] || default_open_command
      selection = File.expand_path selection, @path
      selection = relative_path_under_working_directory selection
      selection = sanitize_path_string selection
      ensure_appropriate_window_selection

      @active_finder.open_selection command, selection, options
    end

    def map key, function, param = nil
      ::VIM::command "noremap <silent> <buffer> #{key} " \
        ":call CommandT#{function}(#{param})<CR>"
    end

    def term
      @term ||= ::VIM::evaluate('&term')
    end

    def register_for_key_presses
      # "normal" keys (interpreted literally)
      numbers     = ('0'..'9').to_a.join
      lowercase   = ('a'..'z').to_a.join
      uppercase   = lowercase.upcase
      punctuation = '<>`@#~!"$%&/()=+*-_.,;:?\\\'{}[] ' # and space
      (numbers + lowercase + uppercase + punctuation).each_byte do |b|
        map "<Char-#{b}>", 'HandleKey', b
      end

      # "special" keys (overridable by settings)
      {
        'AcceptSelection'       => '<CR>',
        'AcceptSelectionSplit'  => ['<C-CR>', '<C-s>'],
        'AcceptSelectionTab'    => '<C-t>',
        'AcceptSelectionVSplit' => '<C-v>',
        'Backspace'             => '<BS>',
        'Cancel'                => ['<C-c>', '<Esc>'],
        'Clear'                 => '<C-u>',
        'CursorEnd'             => '<C-e>',
        'CursorLeft'            => ['<Left>', '<C-h>'],
        'CursorRight'           => ['<Right>', '<C-l>'],
        'CursorStart'           => '<C-a>',
        'Delete'                => '<Del>',
        'Refresh'               => '<C-f>',
        'SelectNext'            => ['<C-n>', '<C-j>', '<Down>'],
        'SelectPrev'            => ['<C-p>', '<C-k>', '<Up>'],
        'ToggleFocus'           => '<Tab>',
      }.each do |key, value|
        if override = get_list_or_string("g:CommandT#{key}Map")
          Array(override).each do |mapping|
            map mapping, key
          end
        else
          Array(value).each do |mapping|
            unless mapping == '<Esc>' && term =~ /\A(screen|xterm|vt100)/
              map mapping, key
            end
          end
        end
      end
    end

    # Returns the desired maximum number of matches, based on available
    # vertical space and the g:CommandTMaxHeight option.
    def match_limit
      limit = VIM::Screen.lines - 5
      limit = 1 if limit < 0
      limit = [limit, max_height].min if max_height > 0
      limit
    end

    def list_matches
      matches = @active_finder.sorted_matches_for @prompt.abbrev, :limit => match_limit
      @match_window.matches = matches
    end

    def buffer_finder
      @buffer_finder ||= CommandT::BufferFinder.new
    end

    def file_finder
      @file_finder ||= CommandT::FileFinder.new nil,
        :max_depth              => get_number('g:CommandTMaxDepth'),
        :max_files              => get_number('g:CommandTMaxFiles'),
        :max_caches             => get_number('g:CommandTMaxCachedDirectories'),
        :always_show_dot_files  => get_bool('g:CommandTAlwaysShowDotFiles'),
        :never_show_dot_files   => get_bool('g:CommandTNeverShowDotFiles'),
        :scan_dot_directories   => get_bool('g:CommandTScanDotDirectories')
    end

    def jump_finder
      @jump_finder ||= CommandT::JumpFinder.new
    end

    def tag_finder
      @tag_finder ||= CommandT::TagFinder.new \
        :include_filenames => get_bool('g:CommandTTagIncludeFilenames')
    end
  end # class Controller
end # module commandT
