class ContactMailer < ApplicationMailer
  US = 'dev.andremenezes@gmail.com'

  def form_reply_mail
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
    @message = params[:message]
    mail(to: @email, subject: "Obrigado por entrar em contato.")
  end

  def foward_form_mail
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @email = params[:email]
    @message = params[:message]
    mail(to: US, subject: "Nova mensagem enviada por #{@first_name} #{@last_name}")
  end
end
