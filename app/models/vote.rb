class Vote < ActiveRecord::Base
	belongs_to :user
	belongs_to :voteable, polymorphic: true

	validates :user, :uniqueness => {:scope => [:user_id, :voteable_id, :voteable_type]}
end