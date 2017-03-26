class CollectSavedThingsJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Create web session via Redd
    # ...
    
    # Collect saved things
    all_saved = []
    after = nil
    loop do
      # Get all posts after the post in the 'after' variable
      # Define `reddit`
      results = reddit.me.saved(after: after, limit: 100)
      puts "Fetched #{results.count} posts."
      # Store the fetched results
      results.each do |result|
        thing = SavedThing.find_or_create_by(
          :kind       => result.kind,
          :reddit_id  => result.id,
          :subreddit  => result.subreddit,
          :body       => result.body,
          :link_id    => result.link_id || result.id,
          :link_title => result.title || result.link_title,
          :link_url   => result.link_url || result.url,
          :permalink  => result.permalink
        )
        
        next user.saved_things.include?(thing)
        
        user.saved_things.push(thing)
      end
      
      all_saved.concat(results)
      
      # Keep track of what post to get the saved posts after
      after = results.after
      
      # If after was nil, we've reached the end.
      break if after.nil?
    end
  end
end