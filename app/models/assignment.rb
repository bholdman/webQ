class Assignment < ActiveRecord::Base
  # attr_accessible :title, :body
	belongs_to :ticket
	belongs_to :user  
end
