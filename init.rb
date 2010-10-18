require 'redmine'

#Hooks
require_dependency 'issue_cloner_hook'

Redmine::Plugin.register :redmine_issue_cloner do
  name 'Redmine Issue Cloner plugin'
  author 'Evgenii.S.Semenchuk'
  description 'This plugin is clone issue every 30 or some number of day'
  version '0.0.1'
  url 'http://github.com/evgenii/redmine_issue_cloner'
  author_url 'http://github.com/evgenii'
end
