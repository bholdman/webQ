class Response < ActiveRecord::Base
   attr_accessible :body, :attachments_attributes 

  has_many :attachments, :as => :attachable

  accepts_nested_attributes_for :attachments
  
  belongs_to :ticket
  belongs_to :user
end
