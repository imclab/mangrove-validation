class ClassificationsController < ApplicationController
  before_filter :require_user
  
  def create
    p params
    render :json => {:ok => true}
  end
  
  def update
    @classification = Classification.find(params[:id], :include => [{:track => :user}, :cell])    

    if @classification.update_attributes(:value => params[:value]) && current_user.tracks.include?(@classification.track)
      render :json => {:update => true}, :callback => params[:callback]  
    else
      render :json => {:update => false}, :callback => params[:callback]  
    end
  end
end
