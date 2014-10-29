require 'spec_helper'

describe MessagesController do
  before :each do
    @user = FactoryGirl.create(:user)
    sign_in @user
    @group = FactoryGirl.create(:group)
    contacts = FactoryGirl.create_list(:contact, 2)
    @group.contacts << contacts
  end
  
  it "can send a message" do
    post :deliver, {:message => {"message"=> "This is a test", "group_id" => @group.id }}
    response.should be_success
    expect(assigns(:contacts)).to eq(@group.contacts)
  end
  
end
