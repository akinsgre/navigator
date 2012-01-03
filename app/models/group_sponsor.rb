class GroupSponsor < ActiveRecord::Base
  belongs_to :group
  belongs_to :sponsor
end
