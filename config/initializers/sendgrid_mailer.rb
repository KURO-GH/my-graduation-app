require 'sendgrid-ruby'

class SendgridMailer
  include SendGrid

  def self.send_test_mail(to:)
    mail = SendGrid::Mail.new

    mail.from = Email.new(
      email: 'no-reply@my-graduation-app.com',
      name: 'My Graduation App'
    )

    mail.subject = 'SendGrid API テスト'
    mail.add_content(
      Content.new(type: 'text/plain', value: 'SendGrid API 経由で送信成功！')
    )

    personalization = Personalization.new
    personalization.add_to(Email.new(email: to))
    mail.add_personalization(personalization)

    sg = SendGrid::API.new(api_key: SENDGRID_API_KEY)
    sg.client.mail._('send').post(request_body: mail.to_json)
  end
end
