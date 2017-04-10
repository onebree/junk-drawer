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

  def unsave_thing
  end

  def search
    @things = current_user.saved_things.search(params[:search])
    
    rendered_things = @things.map do |thing|
      content = render_to_string(:partial => thing.type.downcase, :locals => { :thing => thing })
      
      { :id => thing.id, :content => content }
    end
    
    render :json => rendered_things, :status => :ok
  end
end