class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    access_token = AuthService.new.create_user(user_params)
    @user = User.new(user_params)
    respond_to do |format|
      if access_token.blank?
        format.html { render :new }
        format.json { render json: [], status: :unprocessable_entity }
      elsif @user.save && access_token.present?
        @user.update_attribute(:access_token,access_token)
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update_password
  end


  def reset_password
    user = User.find_by_email(params[:email])
    if params[:current_password] == params[:new_password]
      flash[:alert] = "current password and new password should not be same"
      redirect_to update_password_users_path
    elsif user.present? 
      is_updated = AuthService.new.reset_password(user,params[:current_password],params[:new_password]) 
      unless !is_updated
        user.update_attribute(:password,params[:new_password])
        flash[:notice] = "Successfully updated password"
        redirect_to login_path
      else
        flash[:alert] = "Password not updated"
        redirect_to update_password_users_path
      end        
    else
      flash[:alert] = "User not present with email #{params[:email]}"
      redirect_to update_password_users_path
    end
  end

  def details

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first_name,:last_name,:email, :password, :password_confirmation,:image,:access_token)
    end
end
