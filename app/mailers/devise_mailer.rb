class DeviseMailer < Devise::Mailer
  default from: 'k.s06020608@gmail.com'
  layout 'mailer'

  def reset_password_instructions(record, token, opts = {})
    @token = token
    @resource = record
    opts[:subject] ||= "パスワード再設定"

    # SendGrid メール作成
    from = SendGrid::Email.new(email: 'k.s06020608@gmail.com')
    to = SendGrid::Email.new(email: record.email)
    content = SendGrid::Content.new(
      type: 'text/html',
      value: "パスワード再設定リンク: #{edit_password_url(record, reset_password_token: token)}"
    )

    mail = SendGrid::Mail.new
    mail.from = from
    mail.subject = opts[:subject]
    mail.add_content(content)

    # Personalization に宛先をセット
    personalization = SendGrid::Personalization.new
    personalization.add_to(to)
    mail.add_personalization(personalization)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)

    Rails.logger.info "SendGrid status: #{response.status_code}"
  end
end
