class SavedThing < ApplicationRecord
  actable

  belongs_to :user

  def subreddit_url
    "//reddit.com/#{subreddit}/"
  end
end
