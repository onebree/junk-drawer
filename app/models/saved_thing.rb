class SavedThing < ApplicationRecord
  has_and_belongs_to_many :users

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
