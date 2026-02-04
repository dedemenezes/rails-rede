class GalleriesController < ApplicationController
  def show
    @gallery = Gallery.includes(banner_attachment: :blob).find_by(name: params[:name]) || Gallery.find(params[:id])
    # @albums = @gallery.published_albums.sort_by(&:updated_at).reverse
    if params[:t].present?
      case params[:t]
      when 'documentos'
        @albums = @gallery.albums.where(category: 'document', published: true).order(updated_at: :desc)
        # @albums = @albums.select { _1.documents.attached? }
        add_breadcrumb 'Acervo (Documentos)', documentos_galleries_path
        add_breadcrumb "#{@gallery.name} (Documentos)", gallery_path(@gallery), current: true
      when 'imagens'
        @albums = @gallery.albums.includes(banner_attachment: :blob).where(category: 'photo',
                                                                           published: true).order(updated_at: :desc)
        # @albums = @albums.select { _1.documents.attached? }
        add_breadcrumb 'Acervo (Imagens)', imagens_galleries_path
        add_breadcrumb "#{@gallery.name} (Imagens)", gallery_path(@gallery), current: true
      when 'videos'
        @albums = @gallery.albums.where(category: 'video', published: true).order(updated_at: :desc)
        # @albums = @albums.select { _1.documents.attached? }
        add_breadcrumb 'Acervo (Videos)', videos_galleries_path
        add_breadcrumb "#{@gallery.name} (Videos)", gallery_path(@gallery), current: true
      end
    else
      redirect_to root_path, alert: 'Categoria do acervo deve ser especificada', status: :forbidden
    end

    authorize @gallery
  end

  def imagens
    @galleries = policy_scope(Gallery)
                 .includes(:albums, banner_attachment: :blob)
                 .joins(albums: :photos_attachments)
                 .merge(Album.published_with_photos)
                 .distinct
  end

  def videos
    @galleries = policy_scope(Gallery)
                 .includes(:albums, banner_attachment: :blob)
                 .joins(albums: :documents_attachments)
                 .merge(Album.published_with_documents)
                 .distinct
  end
end
