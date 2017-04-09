class Comment < SavedThing
  def body
    payload["body"]
  end

  def link_author
    payload["link_author"]
  end

  def link_id
    payload["link_id"]
  end

  def link_url
    payload["link_url"]
  end

  def permalink
    "//reddit.com/r/#{subreddit}/comments/#{link_id}//#{reddit_id}"
  end
end