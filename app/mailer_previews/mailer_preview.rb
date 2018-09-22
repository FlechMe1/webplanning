class MailerPreview < ActionMailer::Preview

  def send_access_link
    Mailer.send_access_link(Member.first)
  end

end
