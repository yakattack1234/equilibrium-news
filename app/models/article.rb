class Article < ActiveRecord::Base
  #username, message
  belongs_to :user
end