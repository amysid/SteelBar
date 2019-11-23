class UsersController < ApplicationController
  before_action :find_user, except: [:index,:new,:create]
  layout 'admin_lte_2'
  def index
    @users = User.all.where.not(role: 0)
  end

  def new
    @user = User.new
  end

  def edit

  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = ["User created successfully."]
      redirect_to users_path
    else
      flash[:alert] = @user.errors.full_messages
      render :new
    end
  end

  def update
    if @user.update(user_params)
      flash[:notice] = ["User updated successfully."]
      redirect_to users_path
    else
      flash[:alert] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = ["User deleted successfully."]
    else
      flash[:alert] = @user.errors.full_messages
    end
    redirect_to users_path
  end

  private
  def find_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.require(:user).permit(:id,:full_name,:mobile,:email,:gender,:address,:image)
  end
end
