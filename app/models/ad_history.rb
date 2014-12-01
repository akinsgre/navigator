class AdHistory < ActiveRecord::Base
  validates_presence_of :group_id, :sponsor_id, :contact_id
end
