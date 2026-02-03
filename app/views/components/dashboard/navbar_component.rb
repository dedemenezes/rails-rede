# frozen_string_literal: true

class Dashboard::NavbarComponent < ApplicationComponent
  include Phlex::Rails::Helpers::ImageTag
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::Routes
  include Devise::Controllers::Helpers

  def initialize(user:)
    @user = user
  end

  def view_template
    header(
      class: "navbar navbar-dark sticky-top bg-white flex-column flex-md-row align-items-start align-items-md-center flex-md-nowrap p-0",
      data_controller: "css-classes",
      data_action: "scroll@window->css-classes#onScroll",
      data_css_classes_scrolling_class: "shadow-elevation-2"
    ) do
      link_to root_path,
              class: "navbar-brand col-md-3 col-lg-3 col-xl-2 me-0 px-3 fs-6" do
        image_tag "Logo_PEA.png",
                  width: "186px",
                  alt: "Logo do PEA Rede Observação"
      end
      button(
        class: "navbar-toggler position-absolute d-md-none collapsed",
        type: "button",
        data_bs_toggle: "collapse",
        data_bs_target: "#sidebarMenu",
        aria_controls: "sidebarMenu",
        aria_expanded: "false",
        aria_label: "Toggle navigation"
      ) do
        i(class: "fas fa-bars text-rede-primary")
      end
      # input(
      #   class: "form-control form-control-dark w-100 rounded-0 border-0",
      #   placeholder: "Search",
      #   aria_label: "Search"
      # )
      div(class: "navbar-nav") do
        div(class: "nav-item text-nowrap") do
          if user_signed_in?
            link_to "Sair",
                    destroy_user_session_path,
                    data: {
                      turbo_method: :delete
                    },
                    class: "nav-link px-3"
          end
        end
      end
    end
  end

  private

  attr_reader :user

  def user_signed_in?
    # TODO: Implement me
    user
  end
end
