class Tileset < ApplicationRecord
  NON_ASCII_CHARS_REGEX = /[^\x00-\x7F]+\ *(?:[^\x00-\x7F]| )*/
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :name, uniqueness: { scope: :mapbox_id }
  before_validation :strip_name!
  # before_validation :set_mapbox_id

  validate :ensure_kml_attached

  has_one_attached :kml

  def replace_non_ascii_with_ascii(text)
    normalized_text = Unicode::normalize_KD(text).gsub(/[^\x00-\x7F]/, '')

    mapping = {
      'À' => 'A', 'Á' => 'A', 'Â' => 'A', 'Ã' => 'A', 'Ä' => 'Ae', 'Å' => 'A',
      'Æ' => 'AE', 'Ç' => 'C',
      'È' => 'E', 'É' => 'E', 'Ê' => 'E', 'Ë' => 'E',
      'Ì' => 'I', 'Í' => 'I', 'Î' => 'I', 'Ï' => 'I',
      'Ð' => 'D', 'Ñ' => 'N',
      'Ò' => 'O', 'Ó' => 'O', 'Ô' => 'O', 'Õ' => 'O', 'Ö' => 'Oe', 'Ő' => 'O',
      'Ø' => 'O',
      'Ù' => 'U', 'Ú' => 'U', 'Û' => 'U', 'Ü' => 'Ue', 'Ű' => 'U',
      'Ý' => 'Y',
      'Þ' => 'TH',
      'ß' => 'ss',
      'à' => 'a', 'á' => 'a', 'â' => 'a', 'ã' => 'a', 'ä' => 'ae', 'å' => 'a',
      'æ' => 'ae', 'ç' => 'c',
      'è' => 'e', 'é' => 'e', 'ê' => 'e', 'ë' => 'e',
      'ì' => 'i', 'í' => 'i', 'î' => 'i', 'ï' => 'i',
      'ð' => 'd', 'ñ' => 'n',
      'ò' => 'o', 'ó' => 'o', 'ô' => 'o', 'õ' => 'o', 'ö' => 'oe', 'ő' => 'o',
      'ø' => 'o',
      'ù' => 'u', 'ú' => 'u', 'û' => 'u', 'ü' => 'ue', 'ű' => 'u',
      'ý' => 'y',
      'þ' => 'th',
      'ÿ' => 'y'
    }
    normalized_text.gsub(/[^\x00-\x7F]/) do |char|
      mapping[char] || char
    end
  end

  private

  def ensure_kml_attached
    return if errors.any? || kml.attached?

    errors.add(:kml, 'não pode ficar em branco')
  end

  def set_mapbox_id
    self.mapbox_id = replace_non_ascii_with_ascii(name).downcase.gsub(' ', '_')
  end


  def strip_name!
    self.name = name.strip unless name.nil?
  end


end
