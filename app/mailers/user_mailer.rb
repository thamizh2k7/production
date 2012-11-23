class UserMailer < ActionMailer::Base
  default from: "admin@sociorent.com"

  def welcome_email(user)
  	@general = General.first
    @user = user
    mail(:to => @user.email, :subject => @general.welcome_mail_subject)
  end
end
