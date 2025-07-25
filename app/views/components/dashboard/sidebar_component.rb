# frozen_string_literal: true

class Dashboard::SidebarComponent < ApplicationComponent
  include Phlex::Rails::Helpers::Routes
  def view_template
    nav(id: "sidebarMenu",
        class:"col-md-3 col-lg-3 col-xl-2 d-md-block bg-light sidebar collapse shadow-elevation-2"
    ) do
      div(class: "position-sticky px-2 py-3 sidebar-sticky") do
        ul(class: "nav flex-column") do
          render NavItemComponent.new(extra_css: "mb-2") do
            render NavLinkComponent.new(
                     "",
                     home_path,
                     css_class: "text-primary"
                   ) do
              i(class: "fa-solid fa-house-user me-2")
              plain "Dashboard"
            end
          end
          render NavItemComponent.new(extra_css: "mb-2") do
            render NavLinkComponent.new(
                     "",
                     dashboard_projects_path,
                     css_class: "text-primary"
                   ) do
              i(class: "fa-solid fa-briefcase me-2")
              plain "Projeto"
            end
          end
          render NavItemComponent.new(extra_css: "mb-2") do
            render NavLinkComponent.new "",
                                        dashboard_methodologies_path,
                                        css_class: "text-primary" do
              i(class: "fa-solid fa-table-columns me-2")
              plain "Metodologias"
            end
          end
          render NavItemComponent.new(extra_css: "mb-2") do
            render NavLinkComponent.new "",
                                        dashboard_observatories_path,
                                        css_class: "text-primary" do
              i(class: "fa-solid fa-tower-observation me-2")
              plain "Observatórios"
            end
          end
          render NavItemComponent.new(extra_css: "mb-2") do
            render NavLinkComponent.new "",
                                        dashboard_conflict_types_path,
                                        css_class: "text-primary" do
              i(class: "fa-solid fa-eye me-2")
              plain "Conflitos"
            end
          end
          render NavItemComponent.new(extra_css: "mb-2") do
            render NavLinkComponent.new "",
                                        dashboard_priority_types_path,
                                        css_class: "text-primary" do
              i(class: "fa-solid fa-list me-2")
              plain "Sujeitos prioritários"
            end
          end
          render NavItemComponent.new(extra_css: "mb-2") do
            render NavLinkComponent.new "",
                                        dashboard_articles_path,
                                        css_class: "text-primary" do
              i(class: "fa-solid fa-newspaper me-2")
              plain "Notícias"
            end
          end
          render NavItemComponent.new(extra_css: "mb-2") do
            render NavLinkComponent.new "",
                                        dashboard_tags_path,
                                        css_class: "text-primary" do
              i(class: "fa-solid fa-tag me-2")
              plain "Tags"
            end
          end
          render NavItemComponent.new(extra_css: "mb-2") do
            render NavLinkComponent.new "Projeto",
                                        dashboard_mapbox_tilesets_path,
                                        css_class: "text-primary" do
              i(class: "fa-solid fa-map me-2")
              plain "Tilesets"
            end
          end
        end
      end
    end
  end
end
