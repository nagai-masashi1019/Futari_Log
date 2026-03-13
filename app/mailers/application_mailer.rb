class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAIL_FROM", "test@example.com")
  layout "mailer"

  private

  # ActionMailer が最終的に呼ぶ配送処理を上書き
  def deliver_mail(mail)
    client = Resend::Client.new(api_key: ENV.fetch("RESEND_API_KEY"))

    client.emails.send(
      from: mail.from.first,
      to: mail.to,
      subject: mail.subject,
      html: mail.body.decoded
    )
  end
end
