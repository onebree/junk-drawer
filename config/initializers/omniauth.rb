Rails.application.config.middleware.use OmniAuth::Builder do
  unless Rails.env.production?
    provider :developer, :fields => [:email]
  end

  provider :reddit, ENV["REDDIT_KEY"], ENV["REDDIT_SECRET"], :scope => ["save", "identity", "history"]
end
