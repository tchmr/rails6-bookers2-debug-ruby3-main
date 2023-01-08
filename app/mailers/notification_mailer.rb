class NotificationMailer < ApplicationMailer
  def group_notice
    @user = params[:user]
    @title = params[:title]
    @content = params[:content]
    mail(to: @user.email, subject: @title)
  end
end
