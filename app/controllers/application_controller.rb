class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_breadcrumbs
  before_action :authorize_dashboard_user_if_admin if :dashboard_controller?

  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  # rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # def user_not_authorized
  #   flash[:alert] = "You are not authorized to perform this action."
  #   redirect_to(root_path)
  # end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :username, :avatar, :staff])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :username, :avatar, :staff])
  end

  def add_breadcrumb name, path, current = false
    @breadcrumbs << {
      name:    name,
      path:    path,
      current: current
    }
  end

  def set_breadcrumbs
    @breadcrumbs = []
  end

  private

  def authorize_dashboard_user_if_admin
    authorize [:dashboard, current_user]
  end

  def dashboard_controller?
    params[:controller] =~ /dashboard/
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/ || dashboard_controller?
  end
end
