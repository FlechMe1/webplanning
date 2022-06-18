class MailerPreview < ActionMailer::Preview

  def send_access_link
    Mailer.send_access_link(Member.first)
  end

  #devise

  def confirmation_inscription
    DeviseMailer.confirmation_instructions(User.first, "FakeMe")
  end

end