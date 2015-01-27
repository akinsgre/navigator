module ContactsHelper
  def show_contact_or_group(text)
    link_to text, contact_path(@contact) unless @group
    link_to text, group_contact_path(@group, @contact) if @group
  end
  def edit_contact_or_group(text)
    link_to text, edit_contact_path(@contact) unless @group
    link_to text, edit_group_contact_path(@group, @contact) if @group
  end
  def contact_send_verification(text)
    link_to "Verify", "#{contact_send_verification_path}?entry=#{text}"
  end

end
