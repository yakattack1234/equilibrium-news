class User < ActiveRecord::Base
  #username, message
  has_many :article
end