class Ticket < ActiveRecord::Base
  attr_accessible :subject, :body, :url
  
  belongs_to :user
  belongs_to :department
  belongs_to :status
  has_many :responses
end
