# Issue cloner
Redmine plugin that clone issues at the start of month and postpone issues dates

## Install plugin
1. cd /path_to_you_app/vendor/plugins
2. git clone git://github.com/evgenii/redmine_issue_cloner.git
3. cd ../../ 
4. rake db:migrate_plugins - to add columns
5. ruby script/server - to start application. Enjoy!

## Clone operatoin
Add rake task to crontab for run 'rake issue_cloner:clone'

Example:

> crontab -e

choose text editor, then insert code

>0 7 * * * cd /full/path/to/your/rails/application && rake issue_cloner:clone &> /tmp/cron_issue_cloner.log

save it and crone will automatic starting 

To start/stop/restart cron (on debian) use:

> /etc/init.d/cron command

## Language
For now support only:

* Russian
* Ukrainian
* English

