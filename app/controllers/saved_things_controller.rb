class SavedThingsController < ApplicationController
  def search
    @things = current_user.saved_things.search(params[:search])
    
    rendered_things = @things.map do |thing|
      content = render_to_string(:partial => thing.type.downcase, :locals => { :thing => thing })
      
      { :id => thing.id, :content => content }
    end
    
    render :json => rendered_things, :status => :ok
  end
end