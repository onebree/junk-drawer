class HomeController < ApplicationController
  skip_before_action :authenticate
  skip_before_action :auth_required
  
  def index
  end
end