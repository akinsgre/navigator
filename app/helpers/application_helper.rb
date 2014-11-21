module ApplicationHelper
  def build_menu(menu_map)
    unless menu_map.nil?
      menuLayout = raw("<div class=\"span12 row_fluid\" style=\"background-color:blue\">") 

      menu_map.each do |key,value|
        menuLayout << link_to( key, value) unless key == "Destroy"
        menuLayout << link_to(key, value, :confirm => 'Are you sure?', :method => :delete) if key == "Destroy"
        menuLayout << raw("&nbsp")
      end 

      menuLayout << raw("</div>") 
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
