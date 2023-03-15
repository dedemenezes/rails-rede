class Dashboard::GalleriesController < ApplicationController
  layout 'dashboard'

  before_action :set_gallery, only: %i[edit update destroy]

  def index
    @galleries = Gallery.includes(:observatory, :methodology, :albums, banner_attachment: :blob).all
  end

  def new
    @gallery = Gallery.new
  end

  def create
    binding.break
    @gallery = Gallery.new(gallery_params)
    if @gallery.save
      set_tags
      redirect_to dashboard_galleries_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @album = Album.new
  end

  def update
    if @gallery.update(gallery_params)
      set_tags
      redirect_to dashboard_galleries_path
      if params[:gallery].keys.all? 'published'
        if @gallery.published
          flash[:notice] = 'Acervo publicado'
        else
          flash[:alert] = 'Acervo despublicado'
        end
      else
        flash[:notice] = 'Acervo atualizado'
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @gallery.destroy
    redirect_to dashboard_galleries_path, notice: 'Galeria destruída'
  end

  private

  def set_tags
    ids = params[:gallery][:tag_ids].reject { |id| id.match?(/[a-zA-Z]/) }
    tag_names = params[:gallery][:tag_ids].select { |id| id.match?(/[a-zA-Z]/) }

    tags = tag_names.map { |name| Tag.create(name:) }
    tags << Tag.where(id: ids)
    tags = tags.flatten
    tags.each do |tag|
      Tagging.create! tag:, taggable: @gallery
    end
  end

  def set_gallery
    @gallery = Gallery.find(params[:id])
  end

  def gallery_params
    params.require(:gallery).permit(:name, :category, :published, :banner, :is_event, :event_date)
  end
end
