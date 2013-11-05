class Ticket < ActiveRecord::Base
  attr_accessible :subject, :body, :url, :user_tokens, :title, :description, :attachments_attributes 

  has_many :attachments, :as => :attachable

  accepts_nested_attributes_for :attachments
  
  has_many :assignments
  has_many :users, :through => :assignments
  
  
  belongs_to :department
  belongs_to :status
  has_many :responses
  
  
  
  attr_reader :user_tokens
  
  def user_tokens=(ids)
	 self.user_ids = ids.split(",")
  end
  
  def self.search(search)
	if search
		where('subject LIKE ? OR body LIKE ?', "%#{search}%", "%#{search}%")
	else
		scoped
	end
  end
  
end
