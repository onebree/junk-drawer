class Comment < ApplicationRecord
  acts_as :saved_thing

  def reddit_permalink
    "#{subreddit_url}comments/#{link_id.gsub('t3_', '')}//#{reddit_id}/"
  end
end
