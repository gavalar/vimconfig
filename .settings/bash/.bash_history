ack 'fn100-women'
cd ../../../
ack 'fn100-women'
vim fno//aplication/configs/navigation.xml
cd fno/application/configs/
vim navigation.xml 
git st
git ci -am "Update the Navigation to change the year for the FN100-Women link from 2011 to 2012"
git reset --hard HEAD~1
git lg
git st
git flow feature start 1650-FN100Women
vim navigation.xml 
git ci -am "Update the Navigation to change the year for the FN100-Women link from 2011 to 2012"
git push origin feature/1650-FN100Women
git br -a
ssh dev01
cd sites/projects/fno
git st
vim application/controllers/
git st
git rev application/controllers/Fn100Controller.php
ssh end2end 
ssh web1
ssh dev01
ssh web1
ssh web2
ssh web3
ssh web1
ssh web2
vimdiff ~/Desktop/FNSubscribers.csv ~/Desktop/FNSubscribers_test.csv 
vim ~/Desktop/FNSubscribers_test.csv 
ssh web2
cd sites/
cd projects/fno
git st
git br -a
git co develop
git fetch
git pull
git flow feature finish 1646-Camradata
git flow feature finish 1651-RemoveFINS
git flow feature finish 1648-ChangeEmailPref
git st
git flow finish ContactNumbers
git flow feature finish ContactNumbers
git pod
git pom
git co master
git pull
git lg
git pod
cd ~/sites/share/library/Fno
git br
git co 645-Omniture
git co 1645-Omniture
git co feature/11645-Omniture
git co feature/1645-Omniture
git co develop
git fetch
git pull
git flow feature finish 1645-Omniture
git flow relase start 2.46.4
git flow release start 2.46.4
git flow release finish 2.46.4
git pom
git co master
git pull
git st
git pom
git pod
cd ../../../projects/fno
git st
git br -a
git flow feature finish 1650-FN100Women
git fetchj
git fetch
git co master
git pull
git ls
git lg
git flow release start 2.46.2
git flow release finish 2.46.2
git pod

git pom
ssh dev01
ssh web1
cd sites/projects/fno
ll
ssh dev01
ssh web1
ssh web3
ssh web2
cd sites/projects/fno
ack 'addThis'
vim application/views/scripts/content/story.phtml
cd sites/
ll
cd projects/fno
git lg
git flow hotfix start 2.46.3
ack 'Your email domain has been recognised as part of a corporate subscription'
vim application/controllers/TrialController.php +206
fg
ack contactNumbers
fg
vim application/controllers/TrialController.php +206
ack 'subscription is available to your company'
cd ../../
ack 'subscription is available to your company'
vim share/library/Fno/Validate/TrialProcessScenarios.php
fg
git st
cd -
git st
git ci -am "Fixing contactNumbers on trail process"
git flow hotfix finish 2.46.3
git pod
git pom
fg
git lg
git show 5e8df62
ssh web1
ssh web1
ssh sys01
vim /home/corbettg/Desktop/FNSubscribers.new.csv 
cd sites/projects/group-admin/
ll
cd application/
ll
svn st
svn log | more
svn show -r 8487
ssh git01
ssh web2
ssh web1
ssh web2
ssh dev01
cd sites/projects/fno
git st
git df
git br
git flow feature finish 1582-AddCorpToPaper
git st
git df application/controllers/TrialController.php
vim application/controllers/TrialController.php
git add .
git st
git flow feature finish 1582-AddCorpToPaper
git ci -am "Fixing merge Errors"
git flow feature finish 1582-AddCorpToPaper
git st
git pod
cd ~/sites/share/library/Fno
git st
git br
git co develop
git pull
git st

git pull
cd -
git st
ssh api01
web1
ssh web1
man sed
vim 
ssh web2
ssh end2end 
ssh web2
ssh web3
whois 219.154.133.225
cd sites/
svn st
svn ci microsites/fno-mediakit/pdf/Events-and-Publishing-Calendar-2013.pdf -m "Update to MediaKit Events and Publishing Calendar 2013 - Helpdesk"
ssh web1
ssh web1
ssh dev01
ssh web2
ssh web1
ssh web2
htop
cd sites/
cd 
vim sites/
cd sites/
lll
ll
vim .httpd/fno.inc 
cd projects/
ll
svn up
git clone git01:/efn/scm/git/projects/site-helper.git site-helper
cd /var/www/share/
cd ../share/
ll
cd conf/
ll
cd environment/
ll
cat '
scp web1:/var/www/share/conf/environment/hosts.ini .
cd ~/sites/
vim projects/site-helper/application/bootstrap.php +112
cd projects/site-helper/application/
ll
cd modules/
ll
cd email-unsubscribe/
ll
cd controllers/
ll
vim IndexController.php 
c d ../../../../
cd ../../../../
ack 'We are sorry but a general problem occured which meant we could not successfully complete your request '
fg
cd ../../
ack 'Efn_Key_EmailUnsubscribe'
fg
svn st
cd projects/site-helper/
git st
git df
git rev application/modules/default/controllers/ErrorController.php application/modules/default/views/scripts/error/error.phtml
git st
git df
git st
git stash
git flow init
git flow feature start 1577-WeeksEdition
git pull
git st
git fetch
git merge origin develop
git st
git flow feature start 1577-WeeksEdition
git br -a
git pull origin develop
git flow feature start 1577-WeeksEdition
git st
git co develop
git st
git lg
git pod
git pom
git co feature/1577-WeeksEdition 
git st
git push origin feature/1577-WeeksEdition
git info
git st
git unstash
git diff htdocs/index.php
git rev htdocs/index.php
git ci -am "Hard code change for 'sotw' to 'weeks_edition' as ini file changed but sill requiring sotw to work"
git push
cd ~/.git
cd ~/.vim
git info
ll
cd ../
ssh dev01
ping ftp.efn.co.uk
ssh development 
cd sites/projects/site-helper/application/modules/email-unsubscribe/
vim controllers/FnoController.php 
ssh web1
ssh web3
ssh web2
ssh web1
cd sites/
ll
vim .httpd/
cd microsites/
ll
scp dev01:/efn/www/blog.tar .
tar -xzvf blog.tar 
ll
mv blog.efinancialnews.com/ montecarlo.blog
ll
vim ../.httpd/fno.inc 
cd montecarlo.blog/
ll
vim .htaccess 
vim wp-config.php
ping dev01
vim wp-config
vim wp-config.php 
fg
mysql -h dev01 -u montecarlo -p m0nt3car10
mysql -h dev01 -u montecarlo -p=m0nt3car10
ping dev01
ssh dev01 
sudo vim /etc/hosts
ping 10.177.133.109
ping dev01
ssh dev01
ping 31.222.169.191
ping 10.177.133.109
ssh web1
ping 31.222.169.191
ssh dev01
cd sites/
ack 'addThis'
vim fno/application/views/scripts/content/story.phtml
wget http://downloads.zend.com/studio-eclipse/8.0.1/ZendStudio-8.0.1-x86.tar.gz
ssh dev01
cd sites/projects/fno
git log 
git lg 
ssh web2
ssh web1
ssh web3
vim gav.php
ssh fnohelpdesk@10.16.82.95
tail -f /var/log/vbox-install.log
ssh end2end 
sudo /etc/init.d/vboxdrv setup
vim /var/log/vbox-install.log
vbox-upgrade 
cd sites/projects/fno
git co develop lop
git co develop 
cd ~/sites/share/library/Fno
git st
git fetch
cd ../../../
ack 'AddSubscriptionToGroup'
vim projects/integration/application/models/SlxChange/AddSubscriptionToGroup.php
ack Application_Model_SlxChange
ack 'Application_Model_SlxChange '
fg
cd sites/
ack 'Your email domain has been recognised as part of a corporate subscription'
vim projects/fno/application/controllers/TrialController.php +206
ack 'licencing@dowjones.com'
ack 'licencing@efianacialnews.com'
ack '@efianancialnews.com'
ack '@efinancialnews.com'
ack 'New Auto Sign Up Corporate User'
vim share/library/Fno/Validate/TrialProcess.php +209
ack 'addThis'
cd projects/
ack 'addThis'
git st
cd fno
git st
git lg
git flow hotfix start 2.46.4
ack 'addThis'
vim application/views/scripts/content/story.phtml +177
git st
git ci -am "Updating addThis icons so that we control which icons are displayed"
git push origin
ssh end2end 
fg
git push origin hotfix/2.46.4 
ssh end2end 
vim ../..//projects/fno/application/controllers/TrialController.php
git st
git df
git ci -am "Updating trail 'stage one' and 'end of trail' copy"
git push origin
fg
git st
sudo apt-get install xrdp
ssh end2end 
cd sites/projects/fno
git co master
git lg
cd sites/projects/fno
vim application/controllers/TrialController.php 
git st
git ci -am "Fixing layout issues"
git pod
git pom
ssh end2end
ssh web2
ssh web3
ifconfig
vboxheadless --help
vboxheadless -s dowjones
vboxheadless -s DowJones
vboxmanage list
vboxmanage list vms
vboxmanage startvm DowJones --headless
vboxmanage startvm DowJones --type headless
ifconfig
vboxmange poweroff 
vboxmanage poweroff 
vboxmanage controlvm poweroff 
vboxmanage controlvm poweroff savestate
vboxmanage controlvm poweroff DowJones savestate
vboxmanage list runingvms
vboxmanage list runningvms
vboxmanage controlvm poweroff 'DowJones' savestate
vboxmanage controlvm 'DowJones' savestate
cd Downloads/
ll
locate corbettg.key
cd ../
whereis corbettg
whereis *.gz
tar -xzvf corbettg.key.tar.gz 
cd corbettg/
ll
cd ../
ll
mv corbettg Shared/
ifconfig
vboxmanage startvm DowJones --type headless
cd sites/
git st
cd projects/fno
git co hotfix/2.46.4 
vim application/controllers/TrialController.php 
git ci -am "Resolveing Layout issue with Trail copy"
git push origin
git co develop
git flow hotfix finish 2.46.4
fg
git sh
git st
git df application/controllers/TrialController.php
vim application/controllers/TrialController.php
git st
git df application/controllers/TrialController.php
git add application/controllers/TrialController.php
git st
git flow hotfix finish 2.46.4
git ci -am "Fixing merge issues - line endings"
git flow hotfix finish 2.46.4
git st
git push
git pom
ssh web1
ssh web3
ssh web2
ssh dev01
cd sites/
cd projects/fno
git st
git br -a
git lg
git st
git co develop
git lg
git help lg
git co master
git show dbf3732
git co develop
git st
git show dbf3732
git lg
git br -a
cd ../site-helper/
git st
git df
git ci -am "Fixing the SoTW / Weeks Edition unsubscribe link"
git flow feature finish 1577-WeeksEdition
git lg
git flow release start 2.46
git flow release finish '2.46'
git pod
git pom
ssh web2
ssh web1
ssh web1
ssh dev01
cd sites/projects/site-helper/
cd application/modules/email-unsubscribe/controllers/
scp web2:/var/www/stage/projects/site-helper/application/modules/email-unsubscribe/controllers/FnoController.php .
git st
git df
git s
git sty
git st
git stash
git flow hotfix start 2.46.1
git unstash
git ci -am "Fixing SoTW unsubscribe issue"
git flow hotfix finish '2.46.1'
git pod
git pom
cd ../../../../../
cd site-helper/
git info
ssh dev01
vim
cd .vim
git pull
git st
git pull origin master
vim ../Development/gav.php
ssh dev01
ssh dev01
ssh dev01
ssh web2
