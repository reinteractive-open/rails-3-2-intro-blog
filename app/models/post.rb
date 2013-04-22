class Post < ActiveRecord::Base
  attr_accessible :body, :title

  has_many :comments

  validates_presence_of :body, :title
end


