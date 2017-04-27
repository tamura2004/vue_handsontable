class MembersDecorator < Draper::CollectionDecorator

  def works_rows
    h.render "/members/works/row.json", members: self
  end

  def allocs_rows
    h.render "/members/allocs/row.json", members: self
  end

end
