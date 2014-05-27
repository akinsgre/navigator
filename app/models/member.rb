require 'csv' 

class Member
  def self.save(upload)
    Rails.logger.debug "##### Parsing uploaded Member file #{upload.original_filename}"
    name = upload.original_filename
    csv_text = upload.read
    csv = CSV.parse(csv_text, :headers => true)
    csv.each do |row|
      Rails.logger.debug "     ####### Consume #{row}"
    end
  end
end
