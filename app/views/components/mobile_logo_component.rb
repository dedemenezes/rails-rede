# frozen_string_literal: true

class MobileLogoComponent < ApplicationComponent
  include Phlex::Rails::Helpers::LinkTo
  include Phlex::Rails::Helpers::ImageTag

  def view_template
    link_to root_path, class: "navabar-top-logo offcanvas-title", id: "menuMobileLabel" do
      image_tag 'Logo_PEA.png', width: '186px', alt: 'Logo do PEA Rede Observação'
    end
  end
end
