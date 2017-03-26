class SavedThing < ApplicationRecord
  has_many :user_saved_things
  has_many :users, :through => :user_saved_things

  before_save :set_type

  def name
    "#{kind}_#{reddit_id}"
  end

  def self.searchable_columns
    [:body, :link_title]
  end

  private

  def set_type
    self.type =
      case self.kind
      when "t1"
        "Comment"
      when "t3"
        "Link"
    end
  end
end
