class Department < ActiveRecord::Base
   attr_accessible :name, :prefix
  
  has_many :tickets
  has_many :users
end
