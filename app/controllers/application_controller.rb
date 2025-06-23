class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include SetTags

  before_action :authenticate_user!, if: :dashboard_controller?
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_breadcrumbs, :set_project, :set_social_media_links

  after_action :verify_authorized, except: %i[index mapa documentos imagens videos with_modal], unless: :skip_pundit?
  after_action :verify_policy_scoped, only: %i[index documentos imagens videos with_modal], unless: :skip_pundit?
  after_action :authorize_dashboard_user, if: :dashboard_controller?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name username avatar staff])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name username avatar staff])
  end

  def add_breadcrumb(name, path, current: false)
    @breadcrumbs << {
      name:,
      path:,
      current:
    }
  end

  def set_breadcrumbs
    @breadcrumbs = []
  end

  def set_project
    @project ||= Project.first
  end

  def set_social_media_links
    @project ||= Project.first
    @social_urls = @project.social_links
  end

  def add_default_dashboard_breadcrumb
    return unless params[:controller].match?(/dashboard/)

    current_action = params[:action].match? 'home'
    add_breadcrumb('Dashboard', home_path, current: current_action)
  end

  private

  def authorize_dashboard_user
    authorize [:dashboard, current_user]
  end

  def dashboard_controller?
    params[:controller] =~ /dashboard/
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)|(^contacts$)/ || dashboard_controller?
  end

  def default_url_options
    { host: ENV["DOMAIN"] || "localhost:3000" }
  end
end
