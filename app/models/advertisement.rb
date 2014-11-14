class Advertisement < ActiveRecord::Base
  belongs_to :sponsor
  validates :message, :html_message, :sponsor_id, :presence => true



end

# == Schema Information
#
# Table name: advertisements
#
#  id           :integer         not null, primary key
#  sponsor_id   :integer
#  message      :text
#  html_message :text
#  created_at   :datetime
#  updated_at   :datetime
#

