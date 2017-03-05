class SessionsController < ApplicationController
  def create
  end

  def destroy
  end

  private

  def auth_hash
    request.env["omniauth.auth"]
  end
end
