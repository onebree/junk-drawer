class CollectSavedThingsJob < ApplicationJob
  queue_as :default

  def perform(user)
    session = create_reddit_session(user.access_token)
    
    saved_things = []
    
    after = nil
    
    #loop do
      # Get all posts after the posts in the `after` variable
      results = session.me.saved(:after => after, :limit => 100)
      
      # Store the fetched results
      saved_things.concat(results)
      
      # Keep track of what post to get the saved posts after
      after = results.after
      
      #break if after.nil?
    #end
    
    p saved_things.first
  
    raise
  end

  private

  def create_reddit_session(access_token)
    # TODO - handle dev login
    
    strategy = Redd::AuthStrategies::Web.new(
      :client_id    => ENV["REDDIT_KEY"],
      :redirect_uri => ENV["REDDIT_REDIRECT_URI"],
      :secret       => ENV["REDDIT_SECRET"],
    )
    
    client = Redd::APIClient.new(strategy)
    
    client.access = Redd::Models::Access.new(
      strategy,
      :access_token => access_token
    )
    
    session = Redd::Models::Session.new(client)
  end

  def create_developer_session
    # TODO
  end
end
