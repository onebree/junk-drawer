class SavedThingsController < ApplicationController
  def index
    @subreddits = current_user.saved_things
      .order(:subreddit)
      .group_by(&:subreddit)
  end

  def collect
    CollectSavedThingsJob.perform_now(
      current_user,
      request.env["redd.session"].client.access.access_token
    )

    redirect_to saved_things_path
  end
end