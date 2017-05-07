class User < ApplicationRecord
  has_many :saved_things

  validates_presence_of :uid, :name
end
