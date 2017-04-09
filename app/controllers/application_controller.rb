require "digest/md5"

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate
  before_action :auth_required

  REALM = "JUNK_DRAWER"
  USERS = { ENV["JUNK_DRAWER_USERNAME"] => ENV["JUNK_DRAWER_PASSWORD"] }

  def auth_required
    unless current_user.present?
      if Rails.env.production?
        redirect_to "/auth/reddit"
      else
        redirect_to "/auth/developer"
      end
    end
  end

  def current_user
    User.find_by(:id => session["user_id"])
  end
  
  def create_reddit_session
    # TODO - handle dev login
    
    strategy = Redd::AuthStrategies::Web.new(
      :client_id    => ENV["REDDIT_KEY"],
      :redirect_uri => ENV["REDDIT_REDIRECT_URI"],
      :secret       => ENV["REDDIT_SECRET"],
    )
    
    client = Redd::APIClient.new(strategy)
    
    client.access = Redd::Models::Access.new(
      strategy,
      :access_token => current_user.access_token
    )
    
    session = Redd::Models::Session.new(client)
    
    Rails.logger.info session
    
    session
  end
  
  def create_developer_session
    # TODO
  end

  helper_method :current_user
  helper_method :create_reddit_session

  private

  def authenticate
    authenticate_or_request_with_http_digest(REALM) do |username|
      USERS[username]
    end
  end
end