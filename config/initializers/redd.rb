require "redd/middleware"

Rails.application.config.middleware.use Redd::Middleware,
  :user_agent   => "Redd:junk-drawer (by /u/1bree)",
  :client_id    => ENV["REDDIT_KEY"],
  :secret       => ENV["REDDIT_SECRET"],
  :redirect_uri => ENV["REDIRECT_URI"],
  :scope        => %w(identity save history),
  :via          => "/auth/reddit"