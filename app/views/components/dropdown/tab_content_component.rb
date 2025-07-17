# frozen_string_literal: true

class Dropdown::TabContentComponent < ApplicationComponent
  include Phlex::Rails::Helpers::TurboFrameTag
  def initialize(text, url, options={})
    @text = text
    @url = url
    @frame_id = options[:frame_id]
    @aria_labelledby = options[:aria_labelledby]
    @index = options[:index]
    @active = options[:active]
  end

  def view_template
    turbo_frame_tag(frame_id, class: "tab-pane #{'active' if active?}" , role: "tabpanel", aria_labelledby: aria_labelledby, tabindex: index, src: url, loading: "lazy") do
      div(class: "text-muted") do
        plain text + frame_id
      end
    end
  end

  private

  def active?
    @active == true
  end
  attr_reader :text, :url, :frame_id, :aria_labelledby, :index
end
