require 'spec_helper'
 
describe MessageMailer do
  describe 'send_message' do
    let(:email) { FactoryGirl.create(:email) }
    let(:group) { FactoryGirl.create(:group) }

    let(:mail) { MessageMailer.send_message(email, group.messages.first) }
 
    it 'renders the subject' do
      expect(mail.subject).to eql('Message')
    end
 
  end
end
