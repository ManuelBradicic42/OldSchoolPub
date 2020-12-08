# Preview all emails at http://localhost:3000/rails/mailers/contact_mailer
class ContactMailerPreview < ActionMailer::Preview

  def contact_email
    ContactMailer.contact_email("manuelb@gmail.com", "Manuel Bradicic",
    "0745567645", @message = "Hello, this is a test message")
  end
end
