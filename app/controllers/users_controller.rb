class UsersController < ApplicationController
  before_action :require_user, only: [:update, :edit, :show]

  def new
  	@user = User.new
  end

  def show
    @user = current_user
  end

  def create
  	@user = User.new(user_params)

  	if @user.save
      session[:user_id] = @user.id
  		flash[:notice] = "Your user was created"

  		redirect_to root_path
  	else
  		render :new
  	end

  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = "Your username was updated"
      redirect_to profile_edit_path
    else
      render :edit
    end
  end

  private 
	  def user_params
	  	params.require(:user).permit(:username, :password)
	  end

end
