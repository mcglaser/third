class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :address]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy



  def new
  	@user = User.new
  end


  def show
    @user = User.find(params[:id])
  end



  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user	
      redirect_to @user
    else
    render 'new'
     end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end


  def index
    @users = User.all
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def address
    @user = current_user
  end

  

  private
  

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :address_line_one, :address_line_two, :pays_for_internet, :lives_in_community, :internet_type, :monthly_cost, :community_name)
    end


  def logged_in_user
    unless logged_in?
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end



end
