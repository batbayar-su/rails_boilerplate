# Parent controller buh controller uunees udamshina
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  check_authorization unless: :devise_controller?
  before_action :authenticate_user!, :set_locale, :check_maintenance
  before_filter :configure_permitted_parameters, if: :devise_controller?
  include CanCan::ControllerAdditions

  rescue_from ActionController::RoutingError do |exception|
    error_log exception
    render file: 'public/403.html', layout: false
  end

  rescue_from CanCan::AccessDenied do |exception|
    error_log exception
    render file: 'public/403.html', layout: false
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    error_log exception
    render file: 'public/404.html', layout: false
  end

  rescue_from URI::InvalidURIError do |exception|
    error_log exception
    render file: 'public/404.html', layout: false
  end

  rescue_from ActionController::ParameterMissing do |exception|
    error_log exception
    redirect_to request.referrer
  end

  def routing_error
    raise ActionController::RoutingError, params[:path]
  end

  # rescue_from ActionView::MissingTemplate do |exception|
  #   error_log exception
  #   render file: 'public/500.html', layout: false
  # end

  private

  # maintenance shalgadag before filter
  def check_maintenance
    @state = CoreService.check_state
    return unless @state
    path_included = CoreService.path_included(request.path)
    render file: 'public/maintenancepage.html' unless path_included
  end

  # Hel solih
  def set_locale
    cookies[:locale] = params[:locale] if params[:locale].present?
    I18n.locale = cookies[:locale]
    # current_user.locale
    # request.subdomain
    # request.env["HTTP_ACCEPT_LANGUAGE"]
    # request.remote_ip
  end

  # error handing action
  def error_log(e = nil, custom_message = nil)
    # Sends exception imformations using exception notification gem
    ExceptionNotifier.notify_exception(e)

    # Writes exception data to error log
    error_logger ||= Logger.new("#{Rails.root}/log/error.log")

    error_logger.error("Rendering error with exception: controller => #{params[:controller]}, action => #{params[:action]}, #{e.inspect}") if e
    error_logger.error("Params => #{params.inspect}")
    error_logger.error("(Error has occured) :=> #{e.inspect} #{Rails.backtrace_cleaner.clean(e.backtrace)}") if e
    error_logger.error("(Custom Message) :=> #{custom_message}") if custom_message
  end

  protected

  # devise-n parameter whitelist.
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :email, :password, :password_confirmation) }
  end
end
