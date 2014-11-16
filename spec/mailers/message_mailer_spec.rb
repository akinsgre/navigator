require 'spec_helper'
 
describe MessageMailer do
  before :each do
    @ad = FactoryGirl.create(:advertisement)
  end
  describe 'send email message' do
    let(:email) { FactoryGirl.create(:email) }
    let(:group) { FactoryGirl.create(:group) }
    let(:message) { FactoryGirl.create(:message) }
    let(:advertisement) { FactoryGirl.create(:advertisement)}
    let(:mail) { MessageMailer.send_message(email, message) }

 
    it 'renders the subject' do
      expect(mail.subject).to eq('Message')
      puts mail.body.encoded
      expect(mail.body.encoded).to match("Welcome to my rspec testing message")
      expect(mail.body.encoded).to match("MyHtml")
    end
 
  end

end
