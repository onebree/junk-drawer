class SavedThingsController < ApplicationController
  def index
    @saved_things = current_user.saved_things
  end

  def collect
    CollectSavedThingsJob.perform_now(
      current_user,
      request.env["redd.session"].client.access.access_token
    )

    redirect_to saved_things_path
  end
end