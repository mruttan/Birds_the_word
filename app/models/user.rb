class User < ActiveRecord::Base
 include BCrypt

 #associations
 has_many :scores

  #validations

 validates :name, presence: true, length: {minimum: 2}
 validates :username, presence: true, uniqueness: true, length: {minimum: 2}

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest) == password
  end
 
end