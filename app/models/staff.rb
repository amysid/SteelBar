class Staff < ApplicationRecord
  has_secure_password
  require 'csv'

    def self.search_ilike(args)
	    args = "%#{args.strip}%"
	    self.where("name LIKE ?", args)
    end

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
     Staff.create! row.to_hash
    end
  end
  

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
     cols = ["name", "email", "password", "password_confirmation"]
     csv << cols
    end
  end
end
