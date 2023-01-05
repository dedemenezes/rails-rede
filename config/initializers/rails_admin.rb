RailsAdmin.config do |config|
  config.asset_source = :webpack
  # config.asset_source = :sprockets

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with do
    unless current_user.admin?
      flash[:alert] = 'Sorry, no admin access for you.'
      redirect_to main_app.root_path
    end
  end
  ## == CancanCan ==
  # config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/railsadminteam/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      visible do
        # binding.break
        case bindings[:abstract_model].model_name
        when "Project" then Project.count == 0
        when "Observatory" then true
        else
          false
        end
      end
    end
    export
    bulk_delete
    show
    edit
    delete do
      visible do
        case bindings[:object]
        when Project then Project.count > 0
        when Observatory then true
        else
          false
        end
      end
    end
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  config.included_models = [ 'Observatory', 'Project' ]

  config.model "Observatory" do
    weight 1
    edit do
      %i[name email phone_number].each { |att| field att }
      field :unity_type
      field :categories do
        associated_collection_cache_all true
      end
      field :banner
      field :published
    end
    # configure :observatory_categories do
    #   collection Category.all
    # end
  end
end
