class AddToIssueFields < ActiveRecord::Migration
  def self.up
    add_column :issues, :is_clone_issue, :boolean, :default => false, :null => false
    add_column :issues, :postpone_clone_issue, :integer, :default => 30, :null => false
    add_column :issues, :date_of_clone_issue, :date
  end
  
  def self.down
    remove_column :issues, :is_clone_issue
    remove_column :issues, :postpone_clone_issue
    remove_column :issues, :date_of_clone_issue
  end
end
