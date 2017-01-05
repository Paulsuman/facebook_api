class User

  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic
  include Rails.application.routes.url_helpers
  	field :email, type: String
	field :password, type: String
	field :name, type: String
	
  	require 'digest/sha1'
	before_save :do_hashing, :downcase_fields
	validates_presence_of :email,:password,:name
	validates_uniqueness_of :email
	VALID_EMAIL_REGEX = /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
	validates_length_of :password, minimum: 6 

	 	def hash_password(password)
	 		return Digest::SHA1.hexdigest(password)
	 	end

	 	def do_hashing
	 		self.password = hash_password(self.password)
	 	end
 
	    def downcase_fields
	      self.email = self.email.strip.downcase
	      self.name = self.name.strip.downcase
	    end

	    

end
