module ApplicationHelper
  def build_menu(menu_map)
    unless menu_map.nil?

      menuLayout = raw("<ul class=\"nav nav-pills \"> ") unless menu_map.empty?
      menu_map.each do |key,value|
        menuLayout << raw("<li role=\"presentation\" >") + link_to( key, value) + raw("</li>") unless key == "Remove Group" 
        menuLayout << raw("<li role=\"presentation\" >") + link_to(key, value, :confirm => 'Are you sure?', :method => :delete) + raw("</li>") if key == "Remove Group"
        
      end 
      menuLayout << raw("</ul>") unless menu_map.empty?

    end

  end
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  def resource_class 
    User 
  end
end
