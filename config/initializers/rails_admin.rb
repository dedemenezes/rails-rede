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
        if bindings[:abstract_model].model_name == 'Project' && Project.count > 0
          false
        else
          true
        end
      end
    end
    export
    bulk_delete
    show
    edit
    delete do
      visible do
        if bindings[:abstract_model].model_name == 'Project'
          false
        else
          true
        end
      end
    end
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  config.included_models = [
    'Observatory',
    'Project',
    'Methodology',
    'Member',
    'Category',
    'ConflictType',
    'PriorityType',
    'UnityType',
    'Article'
  ]

  config.model 'Article' do
    weight 2
    edit do
      field :header
      field :sub_header
      field :banner
      field :tags
      field :rich_body

      # field :tags
    end
  end

  config.model "Observatory" do
    weight 1
    edit do
      %i[name email phone_number address rich_description].each { |att| field att }
      field :unity_type do
        # label UnityType.model_name.human
        inline_add false
        inline_edit false
      end
      field :category do
        # label Category.model_name.human
        inline_add false
        inline_edit false
      end
      field :priority_type do
        # label PriorityType.model_name.human
        inline_add false
        inline_edit false
      end
      field :conflict_type do
        # label ConflictType.model_name.human
        inline_add false
        inline_edit false
      end
      field :banner
      field :published
    end
    # configure :observatory_categories do
    #   collection Category.all
    # end
  end

  config.model "Methodology" do
    parent "Project"
  end

  config.model "Member" do
    parent "Project"
  end

  config.model "Category" do
    parent "Observatory"
    list do
      field :id
      field :name
      field :updated_at
    end
  end
  config.model "ConflictType" do
    parent "Observatory"
  end
  config.model "PriorityType" do
    parent "Observatory"
  end
  config.model "UnityType" do
    parent "Observatory"
  end
end
