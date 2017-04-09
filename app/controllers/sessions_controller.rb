class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create
  skip_before_action :auth_required, :only => [:create]
  
  def create
    user = User.find_or_create_by(
      :provider => auth_hash["provider"],
      :uid      => auth_hash["uid"],
      :name     => auth_hash["info"]["name"]
    )
    
    token = auth_hash.credentials.tokens || "developer"
    
    user.update_attribute(:access_token, token)

    session["user_id"] = user.id

    redirect_to saved_things_path
  end

  def destroy
    session.delete("user_id")
    redirect_to home_path
  end

  def failure
    render :plain => "Reddit auth failed. Check logs for details."
  end
  
  protected

  def auth_hash
    request.env["omniauth.auth"]
  end
end