class Collaborator < ApplicationRecord
  validates :name, :testimonial, :location, :avatar, presence: true
  has_one_attached :avatar

  COLOR_STYLES = [
    { bg: "#0069C4", text: 'white' },
    { bg: "#FF7315", text: 'white' },
    { bg: "#083461", text: "white" },
    { bg: "#8C1B21", text: "white" },
    { bg: "#FFDA42", text: "#083461" },
    { bg: "#BDE4F3", text: "#083461" },
    { bg: "#FF303F", text: "white" },
    { bg: "#FFECAB", text: "#083461" },
    { bg: "#FDBB98", text: "#083461" },
    { bg: "#008DD1", text: "white" },
    { bg: "#FFDAD9", text: "#083461" },
    { bg: "#FFFFFF", text: "#083461" }
  ]

  def self.dashboard_headers
    %w[id avatar name updated_at]
  end

  def color_style
    COLOR_STYLES[id % COLOR_STYLES.size]
  end

  def display_occupation
    occupation? ? occupation.capitalize.split.first : ""
  end
end
