Rails.application.config.middleware.use OmniAuth::Builder do
  unless Rails.env.production?
    provider :developer, :fields => [:nickname], :uid_field => :nickname
  end

  previder :reddit, ENV["REDDIT_KEY"], ENV["REDDIT_SECRET"], :scope => "save,identity,history"
end
