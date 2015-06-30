class User < ActiveRecord::Base
	include Sluggable

  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password validations: false

  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}

  sluggable_column :username

  def two_factor_auth?
    !self.phone_number.blank?
  end

  def generate_pin!
    self.update_column(:pin, rand(10 ** 6)) # rand(10 ** 6) creates random 6 digit number
  end

  def remove_pin!
    self.update_column(:pin, nil)
  end

  def admin?
  	self.role == 'admin'
  end

  def moderator?
  	self.role == 'moderator'
  end
  
end