class SavedThing < ApplicationRecord
  actable

  has_many :user_saved_things
  has_many :users, :through => :user_saved_things

  def self.searchable_columns
    [:body, :link_title]
  end

  def subreddit_url
    "//reddit.com/r/#{subreddit}"
  end
end
