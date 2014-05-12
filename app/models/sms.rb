class Sms < Contact
  validates_length_of :entry, :is => 10, :message => 'must be 10 digits, excluding special characters such as spaces and dashes. No extension or country code allowed.', :if => Proc.new{|o| !o.entry.blank?}

  def self.identify
    "Text Message"
  end
end

