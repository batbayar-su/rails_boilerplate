class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: %i[confirm edit update destroy show]

  # GET /
  def index
    per_page = !params[:limit].present? || params[:limit].to_i.zero? ? 5 : params[:limit]
    show_all_users = params[:show_all_users].present? ? params[:show_all_users].to_i : ''
    @users = UserService.get_user_list(params[:page], per_page, show_all_users)
  end

  # GET /show/1
  def show
    @roles = @user.roles
  end

  # GET /users/1/edit
  def edit
    @roles = UserService.get_filtered_role_list(@current_user)
  end

  # PATCH/PUT /users/1
  def update
    UserService.update_user(@user, user_params)
    flash[:success] = t('message.successful')
    redirect_to users_path
  rescue ActiveRecord::RecordInvalid => e
    @roles = UserService.get_filtered_role_list(@current_user)
    error_log e
    flash.now[:error] = t('message.record_invalid')
    render :edit
  end

  # DELETE /users/1
  def destroy
    UserService.delete_user(@user)
    flash[:success] = t('message.successful')
    redirect_to users_path
  rescue ActiveRecord::RecordInvalid => e
    error_log e
    flash[:error] = t('message.record_invalid')
    redirect_to users_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = UserService.find_user(params[:id])
  end

  # Parameter whitelist.
  def user_params
    params.require(:user).permit(:first_name, :last_name, :display_name, :phone_number, :birth_date, :address, :post_code, roles: [])
  end
end
