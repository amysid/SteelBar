class User < ApplicationRecord
    has_secure_password
    mount_uploader :image , ImageUploader
	enum role: ["admin","author"]
	enum gender: ["Male","Female"]
end
