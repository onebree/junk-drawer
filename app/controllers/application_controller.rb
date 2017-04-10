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

  helper_method :current_user

  private

  def authenticate
    authenticate_or_request_with_http_digest(REALM) do |username|
      USERS[username]
    end
  end
end