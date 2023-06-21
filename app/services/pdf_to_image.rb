class PdfToImage
  attr_reader :pdf_attachment_blob, :converted_file_path, :file_name

  def initialize(pdf_attachment_blob)
    @pdf_attachment_blob = pdf_attachment_blob
  end

  def convert
    pdf_url
    open_with_mini_magick
    generate_png_from_pdf_first_page
  end

  private

  def pdf_url
    @pdf_url = @pdf_attachment_blob.url.split("?").first
  end

  def open_with_mini_magick
    @pdf = MiniMagick::Image.open @pdf_url
  end

  def generate_png_from_pdf_first_page
    # @file_name = @pdf_attachment_blob.filename.to_s.gsub(/(\s|-)/, '_').split('.').first
    @file_name = @pdf_attachment_blob.filename.to_s.split('.').first
    @converted_file_path = File.join(Rails.root, 'tmp', "#{file_name}.png")
    MiniMagick::Tool::Convert.new do |convert|
      convert.background "white"
      convert.flatten
      convert.density 150
      convert.quality 100
      convert << @pdf.pages.first.path
      # convert << "png8:preview.png"
      convert << @converted_file_path
    end
  end

end
