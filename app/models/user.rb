class User < ApplicationRecord
  has_many :user_saved_things
  has_many :saved_things, :through => :user_saved_things

  validates_presence_of :uid, :name
end
