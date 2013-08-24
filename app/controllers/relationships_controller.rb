class RelationshipsController < ApplicationController
	before_filter :signed_in_user

	def create
		@user = User.find(params[:relationship] [:followed_id])
		current_user.follow!(@user)
		#redirect_to @user removed this old school
		respond_to do |format|
		format.html { redirect_to @user } #customized this for some Ajax....yeah
		format.js
       end
	end
	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow!(@user)
		#redirect_to(@user)
		respond_to do |format|
		format.html { redirect_to @user } #customized this for some Ajax....yeah
		format.js
	  end
	end
end
