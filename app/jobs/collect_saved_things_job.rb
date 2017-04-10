# require "redd"

class CollectSavedThingsJob < ApplicationJob
  queue_as :default

  def perform(user, access_token)
    raise

    # TODO - Following code is WIP

    strategy = Redd::AuthStrategies::Web.new(
      :client_id    => ENV["REDDIT_KEY"],
      :secret       => ENV["REDDIT_SECRET"],
      :redirect_uri => ENV["REDIRECT_URI"]
    )

    client = Redd::APIClient.new(strategy)

    client.access = Redd::Models::Access.new(
      strategy,
      :access_token => access_token
    )

    session = Redd::Models::Session.new(client)

    saved_things = []

    after = nil

    loop do
      # Get all posts after the posts in the `after` variable
      results = session.me.saved(:after => after, :limit => 100)

      # Store the fetched results
      saved_things.concat(results)

      # Keep track of what post to get the saved posts after
      after = results.after

      break if after.nil?
    end

    # TODO
    saved_things.each do |thing|
      # Find or create record
      
      # Associate with user
    end
  end
end