Rails.application.config.middleware.use OmniAuth::Builder do
  unless Rails.env.production?
    provider :developer, :fields => [:name], :uid_field => :name
  end

  provider :reddit, ENV["REDDIT_KEY"], ENV["REDDIT_SECRET"], :scope => "save,identity,history", :duration => "permanent"
end