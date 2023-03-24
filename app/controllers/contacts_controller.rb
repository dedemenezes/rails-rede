class ContactsController < ApplicationController

  def new
  end

  def create
    ContactMailer.with(
      first_name: contact_params[:first_name],
      last_name: contact_params[:last_name],
      email: contact_params[:email],
      message: contact_params[:message]
    ).form_reply_mail.deliver_later
    ContactMailer.with(
      first_name: contact_params[:first_name],
      last_name: contact_params[:last_name],
      email: contact_params[:email],
      message: contact_params[:message]
    ).foward_form_mail.deliver_later
    redirect_to root_path, notice: 'Sua mensagem foi enviada'
  end

  private

  def contact_params
    params.permit(:first_name, :last_name, :email, :message)
  end
end
