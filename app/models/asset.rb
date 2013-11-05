class Asset < ActiveRecord::Base
  require "carrierwave"
  belongs_to :attachable, :polymorphic => true
  attr_accessible :data_content_type, :data_file_name, :data_file_size
  #has_attached_file :data, :url => "/assets/:id", :path => ":rails_root/public/system/assets/:id/:basename.:extension"
  #Set number to the Max Attachments allowed for owner
Max_Attachments = 5
Max_Attachment_Size = 2.megabyte
 
def url(*args)
data.url(*args)
end
 
def name
data_file_name
end
 
def content_type
data_content_type
end
 
def file_size
data_file_size
end
end

