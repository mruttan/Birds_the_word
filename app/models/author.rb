class Author < ActiveRecord::Base

  #associations

  has_many :quotes
  
end