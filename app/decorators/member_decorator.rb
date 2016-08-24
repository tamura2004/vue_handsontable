module MemberDecorator

  def link_name
    link_to name, member_members_projects_months_path(id)
  end
  

end
