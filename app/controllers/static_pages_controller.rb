class StaticPagesController < ApplicationController
  def home
    if signed_in?
  	@micropost = current_user.microposts.build 
    @feed_items = current_user.feed.paginate(page: params[:page])
  end
  end

  def help
    
  end

  def about #this is the action thats routed if called 

  end 

  def contact 
  	
  end 
end
