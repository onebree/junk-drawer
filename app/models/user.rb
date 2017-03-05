class User < ApplicationRecord
  has_and_belongs_to_many :saved_things
end
