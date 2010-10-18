class IssueClonerHook < Redmine::Hook::ViewListener

  ####################################################  
  # views
  ####################################################  
  
  # context: 
  #   issue - 
  #   form - 
  def view_issues_form_details_bottom( context = { } )
    # the controller parameter is part of the current params object
    # This will render the partial into a string and return it.
    context[:controller].send( :render_to_string, {
       :partial => "hooks/issue_cloner_form", 
       :locals => { :issue => context[:issue], :form => context[:form] }
      })
  end
  
  # context: 
  #   issue - 
  def view_issues_show_details_bottom( context = { } )
    context[:controller].send( :render_to_string, {
       :partial => "hooks/issue_cloner_show", 
       :locals => { :issue => context[:issue] }
      })
  end
  
  ####################################################  
  # controllers
  ####################################################  

  # context: 
  #   params - 
  #   issue - 
  def controller_issues_new_before_save( context = { } )
    if context[:params][:issue][:is_clone_issue] == '1'
      context[:issue].is_clone_issue = context[:params][:issue][:is_clone_issue]
      context[:issue].postpone_clone_issue = context[:params][:issue][:postpone_clone_issue]
      context[:issue].date_of_clone_issue = context[:params][:issue][:date_of_clone_issue]
    else
      context[:issue].is_clone_issue = false
      context[:issue].postpone_clone_issue = 30
      context[:issue].date_of_clone_issue = "0000-00-00"
    end
  end
  
  # context: 
  #   params - 
  #   issue - 
  def controller_issues_edit_before_save( context={ } )
    controller_issues_new_before_save( context )
  end
  
end
