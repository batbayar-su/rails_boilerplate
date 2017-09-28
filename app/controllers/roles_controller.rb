class RolesController < ApplicationController
  load_and_authorize_resource
  before_action :set_role, only: %i[confirm edit update destroy show]

  # GET /
  def index
    per_page = !params[:limit].present? || params[:limit].to_i.zero? ? 5 : params[:limit]
    @roles = UserService.get_role_list(params[:page], per_page)
  end

  # GET /users/new
  def new
    authorize! :new, current_user
    @role = UserService.create_role('')
  end

  # POST /users
  def create
    @role = UserService.create_role(role_params)
    flash[:success] = t('message.successful')
    redirect_to roles_path
  rescue ActiveRecord::RecordInvalid => e
    error_log e
    flash.now[:error] = t('message.record_invalid')
    render :new
  end

  # GET /roles/1/show
  def show
    # authorize! :show, current_user
  end

  # GET /roles/1/edit
  def edit; end

  # PATCH/PUT /roles/1
  def update
    UserService.update_role(@role, role_params)
    flash[:success] = t('message.successful')
    redirect_to roles_path
  rescue ActiveRecord::RecordInvalid => e
    error_log e
    flash.now[:error] = t('message.record_invalid')
    render :edit
  end

  # DELETE /roles/1
  def destroy
    if UserService.check_role_in_use(@role.id)
      UserService.delete_role(@role)
      flash[:success] = t('message.successful')
    else
      flash[:error] = t('message.record_in_use')
    end
    redirect_to roles_path
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = UserService.find_role(params[:id])
  end

  # Parameter whitelist.
  def role_params
    params.require(:role).permit(:name)
  end
end
