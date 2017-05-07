class Link < ApplicationRecord
  acts_as :saved_thing

  def reddit_permalink
    "//reddit.com" + permalink
  end
end
