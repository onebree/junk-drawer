class UserSavedThing < ApplicationRecord
  belongs_to :user
  belongs_to :saved_thing
end
