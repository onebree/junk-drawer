class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create
  skip_before_action :auth_required

  def new
  end

  def create
    Rails.logger.info auth_hash

    user = User.find_or_create_by(
      :provider => auth_hash["provider"],
      :uid      => auth_hash["uid"],
      :name     => auth_hash["info"]["name"]
    )

    session["user_id"] = user.id

    redirect_to root_path
  end

  def destroy
    session.delete("user_id")
    redirect_to root_path
  end

  def failure
    render :plain => "Reddit auth failed. Check logs for details."
  end

  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end
