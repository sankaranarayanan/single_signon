class Mailer < ActionMailer::Base
  extend MailQueue

  default from: ENV['DEFAULT_FROM_ADDRESS']

  def welcome(attributes)
    @user =  Hashie::Mash.new(attributes)
    mail(to: @user.email, subject: I18n.t('.mailer.welcome.subject'))
  end

  def password_reset(attributes)
    @user =  Hashie::Mash.new(attributes)
    mail(to: @user.email, subject: "Forgot Password")
  end
end
