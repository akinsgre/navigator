module GroupsHelper
  def group_link(user, g)
    html = raw("<span style=\"padding-left:30px\">") + g.name + raw("</span>")   unless user.groups.include?(g)
    html = raw("<span class=\"glyphicon glyphicon-cog\"></span>") + link_to(g.name, user_group_path(user, g)) if user.groups.include?(g)
    html
  end
end
