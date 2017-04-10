class SavedThingsController < ApplicationController
  def index
    @saved_things = current_user.saved_things
  end
  
  def collect
    CollectSavedThingsJob.perform_now(
      current_user,
      session["redd_session"]["access_token"]
    )
    redirect_to saved_things_path
  end
end