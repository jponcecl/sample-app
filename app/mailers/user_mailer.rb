class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user)
    @user = user
    mail to: user.email, subject: "Activacion de la cuenta"

    #@greeting = "Hi"
    #mail to: "to@example.org"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  #def password_reset
  def password_reset(user)
    #@greeting = "Hi"
    #mail to: "to@example.org"

    @user = user
    mail to: user.email, subject: "Reiniciar Password"
  end
end
