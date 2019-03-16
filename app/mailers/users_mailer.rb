class UsersMailer < ApplicationMailer
    default from: "andy.haz3@gmail.com"

    def active(user)
      @user = user
      mail(to: @user.email, subject: 'Sample Email')
    end

    def inactive(user)
      @user = user
      mail(to: @user.email, subject: 'Sample Email')
    end

end
