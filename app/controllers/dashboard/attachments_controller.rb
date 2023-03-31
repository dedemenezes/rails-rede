class Dashboard::AttachmentsController < ApplicationController
  def destroy
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge_later
    redirect_to edit_dashboard_album_path(@attachment.record), notice: 'Foto removida'
  end
end
