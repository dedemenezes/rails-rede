class AttachmentsController < ApplicationController
  def destroy
    @attachment = ActiveStorage::Attachment.find(2)
    @attachment.purge
    redirect_to edit_dashboard_project_path(@attachment.record_id)
  end
end
