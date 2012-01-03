class Sponsor < ActiveRecord::Base
  has_many :groups, :through => :group_sponsors
  has_many :group_sponsors
  has_many :contributions
end
