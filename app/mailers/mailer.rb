class Mailer < ActionMailer::Base

  helper :application
  layout 'mailer'

  def send_access_link(member)

    @member = member
    @token = member.token

    @to = @member.email

    @from = "webmaster@eglisedeblois.fr"

    mail(to: @to, from: @from, srespond_to: 'p.gruson@gmail.com', subject: "[Eglise de Blois] Votre fiche membre") do |format|
      format.html
    end
  end

end