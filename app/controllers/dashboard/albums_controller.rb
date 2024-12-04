module Dashboard
  class AlbumsController < ApplicationController
    layout 'dashboard'

    before_action :set_album, only: %i[edit update update_banner destroy]

    def index
      @albums = Album.includes(:gallery, banner_attachment: :blob).all
    end

    def imagens
      # @albums = Album.includes(:gallery).with_only_photos.with_attached_banner
      @albums = Album.includes(:gallery).where(category: 'photo').with_attached_banner
    end

    def documentos
      @albums = Album.includes(:gallery).with_documents.with_attached_banner
    end

    def videos
      @albums = Album.includes(:gallery).with_videos.with_attached_banner
    end

    # def edit_document
    #   @album = Album.find(params[:id])
    #   @attachments = @album.documents.map do |document_attachment|
    #     document_preview_attachment = ActiveStorage::Attachment.joins(:blob)
    #                                                            .where(
    #                                                              'active_storage_blobs.filename ILIKE ?',
    #                                                              document_attachment.blob.filename.base
    #                                                            ).first
    #     {
    #       document_attachment:,
    #       document_preview_attachment:
    #     }
    #   end
    # end

    def new
      @album = Album.new
      @album.videos.build
    end

    def create
      @album = Album.new(album_params)
      begin
        @gallery = Gallery.find(params[:album][:gallery_id])
        @album.gallery = @gallery
      rescue StandardError
      end
      # binding.b
      if @album.save

        attach_documents_first_page_as_photos

        @tags = SetTags.tagging(@album, params)
        if @album.banner.attached?
          redirect_to_correct_album_type_path(notice: 'Album criado')
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
        redirect_to_correct_album_type_path(notice: 'Album atualizado')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def update_banner
      @photo = @album.photos.find { _1.id == params[:photo_id].to_i }
      @album.set_banner(@photo)

      if @album.save
        redirect_to_correct_album_type_path(notice: 'Banner atualizado')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @album.destroy
      redirect_to_correct_album_type_path(notice: 'Album destruído')
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
      params.require(:album)
            .permit(
              :name,
              :is_event,
              :event_date,
              :published,
              :banner,
              :category,
              photos: [],
              documents: [],
              videos_attributes: [[ :id, :name, :description, :url ]]
            )
    end

    def redirect_to_correct_album_type_path(options = {})
      case @album.category
      when 'video'
        redirect_to videos_dashboard_albums_path, options
      when 'document'
        redirect_to documentos_dashboard_albums_path, options
      when 'photo'
        redirect_to imagens_dashboard_albums_path, options
      end
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
        @album.photos.attach(io: File.open(pdf_to_img.converted_file_path), filename: pdf_to_img.file_name,
                             content_type: "image/png")
        FileUtils.rm(pdf_to_img.converted_file_path)
      end
    end
  end
end
