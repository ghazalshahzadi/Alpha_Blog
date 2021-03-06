 class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :require_same_user, only:[:edit, :update, :destroy]
  before_action :require_admin, only: [:destroy]
    def index
     @users = User.all
   end
    def new
   @user = User.new
    end
    def create
      @user = User.new(user_params)
      if @user.save 
        session[:user_id] = @user_id
         flash[:success] = "Welcome to the alpha-blog #{@user.username}"
         redirect_to user_path(@user)
      else
         render 'new'
      end
      end
    def edit
    end
    def update
      if @user.update(user_params)
       flash[:success] = "Your account was updated successfully"
         redirect_to articles_path
       else
      render 'edit'
      end
      end
      def show
       
      end
      def destroy
        @user = User.find(params[:id])
        @user.find
          flash[:dangar]="user and all articles created by user have been deleted"
          redirect_to users_path
      end
   private
    def user_params
      params.require(:user).permit(:username, :password, :email)
   end
   def det_user
    @user = User.find(params[:id])
   end
   def require_same_user
    if current_user != @user and !current_user.admin?
        flash[:danger]="you can only edit your own articles"
        redirect_to root_path
    end 
end 
   def require_admin
    if !logged_in && !current_user.admin?
      flash[:dangar] = "only admin perform that action"
      redirect_to root_path
    end
   end
 end