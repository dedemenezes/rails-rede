module Dashboard
  class AttachmentsController < ApplicationController
    def destroy
      @attachment = ActiveStorage::Attachment.find(params[:id])
      @attachment.purge_later
      purge_document_attachment

      redirect_to edit_dashboard_album_path(@attachment.record), notice: 'Foto removida'
    end

    private

    def purge_document_attachment
      filename = @attachment.blob.filename.to_s

      return nil unless @attachment.record.is_a?(Album)

      document_from_image = ActiveStorage::Attachment.joins(:blob).find_by("active_storage_blobs.filename LIKE ?",
                                                                           "#{filename}.pdf")

      return unless document_from_image

      document_from_image.purge_later
    end
  end
end
