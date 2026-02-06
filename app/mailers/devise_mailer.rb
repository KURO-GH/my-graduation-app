require 'sendgrid-ruby'
include SendGrid

class DeviseMailer < Devise::Mailer
  default from: 'k.s06020608@gmail.com'
  layout 'mailer'

  def reset_password_instructions(record, token, opts = {})
    from = Email.new(email: 'k.s06020608@gmail.com')
    to = Email.new(email: record.email)
    subject = 'Reset password instructions'
    content = Content.new(type: 'text/plain', value: "あなたのパスワードリセットリンクはこちら: #{edit_password_url(record, reset_password_token: token)}")
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    Rails.logger.info "SendGrid status: #{response.status_code}"
  end
end
