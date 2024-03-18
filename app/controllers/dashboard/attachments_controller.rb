module Dashboard
  class AttachmentsController < ApplicationController
    def destroy
      @attachment = ActiveStorage::Attachment.find(params[:id])
      filename = @attachment.blob.filename.base
      @album = @attachment.record
      @attachment.purge_later
      if @album.has_only_photos?
        redirect_to edit_dashboard_album_path(@album), notice: 'Foto removida'
      else
        purge_document_attachment(filename)
        redirect_to edit_dashboard_album_path(@album), notice: 'Documento removido'
      end
    end

    private

    def purge_document_attachment(filename)
      document_attachment = @album.documents.find { _1.blob.filename.base == filename }
      document_attachment.purge_later
    end
  end
end
