class SavedThing < ApplicationRecord
  has_many :user_saved_things
  has_many :users. :through => :user_saved_things

  def kind
    case type
    when "Comment"
      "t1"
    when "Link"
      "t3"
    end
  end

  def name
    "#{kind}_#{reddit_id}"
  end
end
