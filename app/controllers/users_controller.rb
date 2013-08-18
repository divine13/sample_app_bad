class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  before_filter :if_signed_in, only: :new

  def new
  	
  end
  def destroy 
   @des = User.find(params[:id]).destroy
    redirect_to users_path
    flash[:success] = "user destroyed mate"
  end
  def index
    @users = User.paginate(page: params[:page])
  end
  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  def new
  	@user = User.new
  end
  def create
  	@user = User.new(params[:user])
    
  if @user.save
    sign_in @user
      redirect_to @user
      if @user.errors.full_messages.empty?
     flash[:success] = "welcome to Happe"
     end
  else
  	render 'new'
    flash[:error] = "please try again"
    end 
  end
  def edit 
    @user = User.find(params[:id])
  end
  def update
     @user = User.find(params[:id])

       if @user.update_attributes(params[:user])
        flash[:success] = "successfully edited your profile mate"
        sign_in @user
        redirect_to @user
       else
        flash[:error] = "please try again"
        render 'edit'
       end
  end
 private

      # def signed_in_user
      #   unless signed_in?
      #     store_location
      #   end
      #   redirect_to signin_path, notice: "please sign in first to see this page mate" unless signed_in?
      # end

      def correct_user
        @user = User.find(params[:id])
        redirect_to(root_path) unless current_user?(@user)
      end
      def admin_user
        redirect_to(root_path) unless current_user.admin?
      end
      def if_signed_in 
        if signed_in? == true
          flash[:error] = "you can not create an account you already have one mate"
          redirect_to(root_path)
        end
      end
end
