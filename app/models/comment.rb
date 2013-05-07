class Comment < ActiveRecord::Base
  belongs_to :post
  attr_accessible :body

  validates_presence_of :post, :body
end
