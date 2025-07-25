class Tileset < ApplicationRecord
  NON_ASCII_CHARS_REGEX = /[^\x00-\x7F]+\ *(?:[^\x00-\x7F]| )*/
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :name, uniqueness: { scope: :mapbox_id }
  validates :mapbox_id, presence: true
  before_validation :strip_name!
  before_validation :set_mapbox_id
  before_validation :set_mapbox_owner

  validate :ensure_kml_attached
  validate :ensure_mapbox_id_max_length

  has_one_attached :kml

  def self.dashboard_headers
    %w[name mapbox_owner]
  end

  def full_tileset_id
    return nil unless mapbox_owner && mapbox_id

    "#{mapbox_owner}.#{mapbox_id}"
  end

  def ensure_mapbox_id_max_length
    return if errors.any? || mapbox_id.size <= 32

    errors.add(:kml, ' inválido. Nome do arquivo tem que ter no máximo 32 caracteres')
  end

  def ensure_kml_attached
    return if errors.any? || kml.attached?

    errors.add(:kml, 'não pode ficar em branco')
  end

  def set_mapbox_owner
    self.mapbox_owner = ENV.fetch('MAPBOX_USERNAME')
  end

  def set_mapbox_id
    return unless kml.attached?

    self.mapbox_id = replace_non_ascii_with_ascii(kml.blob.filename.to_s[...-4]).downcase.gsub(' ', '_')
  end

  def replace_non_ascii_with_ascii(text)
    normalized_text = Unicode.normalize_KD(text).gsub(/[^\x00-\x7F]/, '')
    mapping = ascii_dictionary
    normalized_text.gsub(/[^\x00-\x7F]/) do |char|
      mapping[char] || char
    end
  end

  private

  # rubocop:disable Metrics/MethodLength
  def ascii_dictionary
    { 'À' => 'A', 'Á' => 'A', 'Â' => 'A', 'Ã' => 'A', 'Ä' => 'Ae', 'Å' => 'A',
      'Æ' => 'AE', 'Ç' => 'C', 'È' => 'E', 'É' => 'E', 'Ê' => 'E', 'Ë' => 'E',
      'Ì' => 'I', 'Í' => 'I', 'Î' => 'I', 'Ï' => 'I', 'Ð' => 'D', 'Ñ' => 'N',
      'Ò' => 'O', 'Ó' => 'O', 'Ô' => 'O', 'Õ' => 'O', 'Ö' => 'Oe', 'Ő' => 'O',
      'Ø' => 'O', 'Ù' => 'U', 'Ú' => 'U', 'Û' => 'U', 'Ü' => 'Ue', 'Ű' => 'U',
      'Ý' => 'Y', 'Þ' => 'TH', 'ß' => 'ss', 'à' => 'a', 'á' => 'a', 'â' => 'a',
      'ã' => 'a', 'ä' => 'ae', 'å' => 'a', 'æ' => 'ae', 'ç' => 'c', 'è' => 'e',
      'é' => 'e', 'ê' => 'e', 'ë' => 'e', 'ì' => 'i', 'í' => 'i', 'î' => 'i',
      'ï' => 'i', 'ð' => 'd', 'ñ' => 'n', 'ò' => 'o', 'ó' => 'o', 'ô' => 'o',
      'õ' => 'o', 'ö' => 'oe', 'ő' => 'o', 'ø' => 'o', 'ù' => 'u', 'ú' => 'u',
      'û' => 'u', 'ü' => 'ue', 'ű' => 'u', 'ý' => 'y', 'þ' => 'th', 'ÿ' => 'y' }
  end
  # rubocop:enable Metrics/MethodLength

  def strip_name!
    self.name = name.strip unless name.nil?
  end
end
