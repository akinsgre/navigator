require 'spec_helper'
 
describe MessageMailer do
  before :each do
    @ad = FactoryGirl.create(:advertisement)
  end
  describe 'send email message' do
    let(:email) { FactoryGirl.create(:email) }
    let(:group) { FactoryGirl.create(:group) }
    let(:message) { FactoryGirl.create(:message, group: group) }
    let(:advertisement) { FactoryGirl.create(:advertisement)}
    let(:mail) { MessageMailer.send_message(email, message, advertisement) }

    it 'renders the subject' do
      expect(mail.subject).to eq('Message from Test Group ')
      expect(mail.body.encoded).to match("Welcome to my rspec testing message")
      expect(mail.body.encoded).to match("MyHtml")
    end
  end
  describe 'send verification request' do
    let(:email) { FactoryGirl.create(:email) }
    let(:mail) { MessageMailer.send_verification(email) }
    it 'renders an email requesting verification' do
      expect(mail.subject).to eq('Please verify your email address')
      
    end
  end

end
