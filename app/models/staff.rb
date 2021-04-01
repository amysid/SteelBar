class Staff < ApplicationRecord
  has_secure_password
  require 'csv'

    def self.search_ilike(args)
	    args = "%#{args.strip}%"
	    self.where("name LIKE ?", args)
    end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      @staff = Staff.new(name: row["Employee Name"], email: row["Email Address"], password: row["Password"], password_confirmation: row["Password"])
     @staff.save!
    end
  end
  
  

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
     cols = ["Employee Name", "Email Address", "Password"]
     csv << cols
    end
  end
end
