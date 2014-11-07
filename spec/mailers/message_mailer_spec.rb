require 'spec_helper'
 
describe MessageMailer do
  describe 'send email message' do
    let(:email) { FactoryGirl.create(:email) }
    let(:group) { FactoryGirl.create(:group) }
    let(:message) { FactoryGirl.create(:message) }

    let(:mail) { MessageMailer.send_message(email, message) }
 
    it 'renders the subject' do


      expect(mail.subject).to eql('Message')
    end
 
  end

end
