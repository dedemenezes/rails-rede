module Dashboard
  class AttachmentsController < ApplicationController
    def destroy
      @preview_attachment = ActiveStorage::Attachment.find(params[:id])
      @preview_attachment.purge_later
      if params[:document_attachment_id].present?
        purge_document_attachment
        redirect_to documentos_dashboard_album_path(@preview_attachment.record), notice: 'Documento removido'
      else
        redirect_to imagens_dashboard_albums_path, notice: 'Foto removida'
      end
    end

    private

    def purge_document_attachment
      document_attachment = ActiveStorage::Attachment.find params[:document_attachment_id]
      document_attachment.purge_later
    end
  end
end
