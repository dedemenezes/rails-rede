class Dashboard::AlbumsController < ApplicationController
  layout 'dashboard'

  before_action :set_album, only: %i[edit update update_banner destroy]

  def index
    @albums = Album.includes(:gallery, banner_attachment: :blob).all
  end

  def imagens
    @albums = Album.includes(:gallery, :documents_attachments, banner_attachment: :blob).reject { |album| album.documents.attached? }
  end

  def documentos
    @albums = Album.includes(:gallery, :documents_attachments, banner_attachment: :blob).select { |album| album.documents.attached? }
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    begin
      @gallery = Gallery.find(params[:album][:gallery_id])
      @album.gallery = @gallery
    rescue => exception
    end
    if @album.save

      attach_documents_first_page_as_photos

      @tags = SetTags.tagging(@album, params)
      if @album.banner.attached?
        redirect_to dashboard_albums_path
      else
        redirect_to edit_dashboard_album_path(@album), notice: 'Novo albúm criado'
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if params[:album][:gallery_id]
      @gallery = Gallery.find(params[:album][:gallery_id])
      @album.gallery = @gallery unless @gallery == @album.gallery
    end
    if @album.update(album_params) && @album.banner.attached?

      attach_documents_first_page_as_photos


      @tags = SetTags.tagging(@album, params)
      if @album.documents.attached?
        redirect_to documentos_dashboard_albums_path, notice: 'Album atualizado'
      else
        redirect_to imagens_dashboard_albums_path, notice: 'Album atualizado'
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update_banner
    @photo = @album.photos.find{ _1.id == params[:photo_id].to_i }
    @album.set_banner(@photo)

    if @album.save
      redirect_to dashboard_albums_path, notice: 'Banner atualizado'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @album.destroy
    redirect_to dashboard_albums_path, notice: 'Album destruído'
  end

  private

  def set_album
    if params[:id].match?(/[a-zA-Z]+/)
      @album = Album.includes(photos_attachments: :blob).find_by(name: params[:id])
    else
      @album = Album.includes(photos_attachments: :blob).find(params[:id])
    end
  end

  def album_params
    params.require(:album).permit(:name, :is_event, :event_date, :published, :banner, photos: [], documents: [])
  end

  def attach_documents_first_page_as_photos
    return unless params[:album][:documents]
    return if params[:album][:documents].compact_blank.empty?

    # checkar se temos algum pdf attached.
    attachments = ActiveStorage::Attachment.where record: @album
    new_attachment_names = params[:album][:documents].compact_blank.map(&:original_filename)

    new_docs = attachments.select { |attachment| new_attachment_names.include? attachment.filename.to_s }
    # tendo pdf temos que
    new_docs.each do |doc|
      pdf_to_img = PdfToImage.new doc.blob
      # criar os pngs
      pdf_to_img.convert
      # attach os pngs como photos
      @album.photos.attach(io: File.open(pdf_to_img.converted_file_path), filename: pdf_to_img.file_name, content_type: "image/png")
      FileUtils.rm(pdf_to_img.converted_file_path)
    end
  end
end
