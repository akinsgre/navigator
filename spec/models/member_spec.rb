require 'spec_helper'

describe Member do
  before :each do
    @file = ActionDispatch::Http::UploadedFile.new({
    :filename => 'member_list.csv',
    :type => 'text/csv',
    :tempfile => File.new("#{Rails.root}/spec/fixtures/member_list.csv")
  })

    end
  it "save the file as a list of contacts" do
    Member.save(@file)
  end
end



