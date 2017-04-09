class SavedThingsController < ApplicationController
  def index
    # @saved_things = current_user.saved_things
    @after, @saved_things = collect_saved_things
  end
  
  def collect_saved_things
    session = create_reddit_session
    
    saved_things = []
    
    after = nil
    
    #loop do
      # Get all posts after the posts in the `after` variable
      results = session.me.saved(:after => after, :limit => 100)
      
      # Store the fetched results
      saved_things.concat(results)
      
      # Keep track of what post to get the saved posts after
      p results.after
      after = results.after
      
      #break if after.nil?
    #end
    
    p saved_things.first
    
    [ results.after, saved_things ]
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