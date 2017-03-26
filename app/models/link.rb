class Link < SavedThing
  
  # TODO - check if this conflicts with permalink field for links
  def permalink
    "//reddit.com/" + permalink
  end
end
