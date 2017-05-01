# require "redd"

class CollectSavedThingsJob < ApplicationJob
  queue_as :default

  # TODO - Following code is WIP
  def perform(user)
    strategy = Redd::AuthStrategies::Web.new(
      :user_agent   => "Ruby:Redd:junk-drawer (by /u/1bree)",
      :client_id    => ENV["REDDIT_KEY"],
      :secret       => ENV["REDDIT_SECRET"],
      :redirect_uri => ENV["REDIRECT_URI"]
    )

    client = Redd::APIClient.new(strategy)

    client.access = Redd::Models::Access.new(
      strategy,
      :access_token => user.access_token
    )

    session = Redd::Models::Session.new(client)

    saved_things = []

    after = nil

    # TODO - test with 1 page of 10 entries
    loop do
      # Get all posts after the posts in the `after` variable
      results = session.me.saved(:after => after, :limit => 100)

      # Store the fetched results
      saved_things.concat(results)

      # Keep track of what post to get the saved posts after
      after = results.after

      break if after.nil?
    end

    # For each thing, find or create a Comment or Link record based on name
    # And associate it with user
    saved_things.each do |thing|
      attributes = {
        :name      => thing.name,
        :kind      => "t1",
        :reddit_id => thing.id,
        :subreddit => thing.subreddit_name_prefixed,
        :author    => thing.author.name
      }

      if thing.name.starts_with?("t1_")
        comment = Comment.find_or_create_by(
          attributes.merge({
            :body_html   => thing.body_html,
            :link_author => thing.link_author,
            :link_id     => thing.link_id,
            :link_title  => thing.link_title,
            :link_url    => thing.link_url
          })
        )

        user.comments.push(comment)
      elsif thing.name.starts_with("t3_")
        link = Link.find_or_create_by(
          attributes.merge({
            :title         => thing.title,
            :url           => thing.url,
            :permalink     => thing.permalink,
            :selftext_html => thing.selftext_html,
            :thumbnail     => thing.thumbnail
          })
        )

        user.links.push(link)
      end
    end
  end
end