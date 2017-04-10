class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => :create
  skip_before_action :auth_required, :only => [:redirect]
  
  def redirect
    if request.env["redd.session"].nil?
      redirect_to failure_path
    else
      user = find_or_create_user
      redirect_to saved_things_path
    end
  end

  def destroy
    request.env.delete("redd.session")
    session.delete("user_id")
    redirect_to home_path
  end

  def failure
    render :plain => "Reddit auth failed. Check logs for details."
  end

  private

  def find_or_create_user
    user = User.find_or_create_by(
      :uid  => current_auth.me.id,
      :name => current_auth.me.name
    )

    session["user_id"] = user.id
  end
end