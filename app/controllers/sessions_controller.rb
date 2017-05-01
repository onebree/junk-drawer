class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, :only => [:redirect]
  skip_before_action :auth_required

  def redirect
    if request.env['redd.error'].nil?
      user = find_or_create_user
      redirect_to saved_things_path
    else
      render_failure(request.env['redd.error'].message)
    end
  end

  def destroy
    request.env.delete("redd.session")
    session.delete("user_id")
    redirect_to home_path
  end

  private

  def find_or_create_user
    reddit = request.env["redd.session"]

    user = User.find_or_create_by(
      :uid  => reddit.me.id,
      :name => reddit.me.name
    )

    user.update_attributes(:access_token => reddit.client.access.access_token)

    session["user_id"] = user.id
  end

  def render_failure(error)
    Rails.logger.error "Error while logging in!"

    message =
      case error
      when "access_denied"
        "Sorry, you clicked decline. <a href='/login'>Login again?</a>"
      when "invalid_state"
        "Did you login through our website? <a href='/login'>(No)</a>"
      else
        "Reddit auth failed. Check logs for details."
    end

    render :html => message.html_safe
  end
end