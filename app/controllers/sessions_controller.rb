class SessionsController < ApplicationController
  layout 'admin_lte_2_login'
  before_action :authenticated_user, only: [:destroy,:profile,:update_profile]
  before_action :un_authenticated,except: [:destroy,:profile,:update_profile]#[:new,:create,:forgot_password,:send_link,:change_password]
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:user][:email]) || Staff.find_by(email: params[:user][:email])
    if @user && @user.authenticate(params[:user][:password])
      login
      flash[:notice] = ["Login successfully."]
      redirect_to root_path
    else
      flash[:alert] = ["Invalid user name or password."]
      redirect_to login_path
    end
  end

  def forgot_password
    @user = User.new
  end

  def send_link
    @user = User.find_by(email: params[:user][:email])
    if @user
      flash[:notice] = ["Password reset link send on registered email id."]
      redirect_to login_path
    else
      flash[:alert] = ["Invalid user."]
      redirect_to login_path
    end
  end
  
  def profile
    @user = current_user
  end

   def update_profile
    @user = current_user
    if @user.update(user_params)
      flash[:notice] = ["Profile updated successfully."]
      redirect_to root_path
    else
      flash[:alert] = @user.errors.full_messages
      render :profile
    end
    
  end
  
  def change_password
    if params[:auth_token].present?
      @user = User.find_by(verificatin_link: params[:auth_token])
      if @user
        if params[:user][:password].present? && params[:user][:confirm_password].present?
      		@user.update(verificatin_link: "",password: params[:user][:password])
      		login
        	flash[:notice] = ["Login successfully."]
        	redirect_to root_path
        end
      else
        flash[:alert] = ["Invalid link."]
        redirect_to login_path
      end
    else
      flash[:alert] = ["Invalid request."]
      redirect_to login_path
    end
  end

  def destroy
    if current_user.present?
    	session[:user] = nil
          flash[:notice] = ["Logout successfully."]
      redirect_to login_path
    # else
      # flash[:alert] = ["Invalid request."]
      # redirect_to root_path
    end
  end

  def login
  	session[:user] = @user.id
  end

  # def verify_user
  # 	return redirect_to root_path if logged_in?
  # end
end
