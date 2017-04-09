class Link < SavedThing
  def media
  end

  def media_embed
  end

  # TODO - check if this conflicts with permalink field for links
  def permalink
    "//reddit.com/" + permalink
  end

  def selftext
  end

  def selftext_html
  end

  def thumbnail
  end

  def title
  end

  def url
  end
end