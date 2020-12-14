class HomeController < ApplicationController
  def home
  end

  def contact
  end


  def request_contact
    name = params[:name]
    email = params[:email]
    telephone = params[:telephone]
    message = params[:message]

    # If there is no email, an error message will be displayed
    if email.blank?
      flash[:alert] = I18n.t('home.request_contact.no_email')

    # Or if there is no message supplied
    elsif message.blank?
      flash[:alert] = I18n.t('messages.request_contact.no_message')

    # Or if there is no message supplied
    else
      ContactMailer.contact_email(email, name, telephone, message).deliver_now
      flash[:notice] = I18n.t('home.request_contact.email_sent')
    end
  redirect_to contact_url
  end
end
