class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :auth_required

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
end
