class CoresController < ApplicationController
  load_and_authorize_resource

  # maintenance huudas
  def maintenance
    @maintenance = CoreService.check_state
    return unless request.post? && params[:switch].present?
    CoreService.change_state(params[:switch])
    redirect_to maintenance_path
  end

  # post code-g oruulhad address butsaadaj ajax-n back-end code
  def post_address
    postcode = params['value'].delete('- ')
    address = CoreService.get_address(postcode)

    respond_to do |format|
      format.json { render json: { success: true, address: address } }
    end
  end
end
