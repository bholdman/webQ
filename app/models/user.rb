class User < ActiveRecord::Base
	attr_accessible :lName, :fName, :seKey, :isAdmin, :department_id
  
	has_many :assignments
	belongs_to :departments
	has_many :tickets, :through => :assignments
	
	has_many :responses
	
	before_create {generate_token(:auth_token)}
  
	def to_param
		seKey
	end
	
	def generate_token(column)
		begin
			self[column] = SecureRandom.base64.tr("+/", "-_")
		end while User.exists?(column => self[column])
	end
end
