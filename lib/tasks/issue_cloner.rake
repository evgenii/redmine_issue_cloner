namespace :issue_cloner do

  desc "Check issue and clone it"
  task :clone => :environment do
    clone_couner = 0
    Issue.find_each( :conditions => "is_clone_issue = true", :batch_size => 100 ) do |issue|

      clone_date = issue.start_date.nil? ? nil : issue.start_date + 1.month
      clone_date = Date.strptime "#{clone_date.year}-#{clone_date.month}-01" unless clone_date.nil?
      if ( !issue.date_of_clone_issue.nil? and Date.today >= issue.date_of_clone_issue ) or
        ( issue.date_of_clone_issue.nil? and !clone_date.nil? and Date.today >= clone_date )

        add_new_attr = {} and issue.attributes.each do |key, value|
          add_new_attr[key] = postpone_date(value, issue.postpone_clone_issue) if value.class.to_s == "Date" and !value.nil?
        end

        new_issue = Issue.create( issue.attributes.merge( add_new_attr.merge( {
          :created_on => DateTime.now, :updated_on => DateTime.now, 
          :status_id => IssueStatus.default.id } ) ) )

        issue.watchers.each do |watcher| 
          Watcher.create( watcher.attributes.merge( :watchable_id => new_issue.id ) )
        end

        #turn off cloning for this issue
        issue.is_clone_issue = false
        issue.save
        clone_couner += 1
      end
    end
    puts "Cloned #{clone_couner} issues."
  end

  def postpone_date( curr_date, postpone_days )
    curr_date + ( (28..31).include?( postpone_days ) ? 1.month : postpone_days.days )
  end

end

