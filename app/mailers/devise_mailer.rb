class DeviseMailer < Devise::Mailer
  default from: 'k.s06020608@gmail.com'
  layout 'mailer'

  # Devise のメソッドをオーバーライド
  def reset_password_instructions(record, token, opts = {})
    # Devise の元メソッドで URL を作る
    opts[:subject] = "パスワード再設定"
    @token = token
    @resource = record

    # SendGrid API で送信
    mail = SendGrid::Mail.new
    mail.from = SendGrid::Email.new(email: 'k.s06020608@gmail.com')
    mail.subject = opts[:subject]
    mail.to = SendGrid::Email.new(email: record.email)
    mail.content = SendGrid::Content.new(
      type: 'text/html',
      value: "パスワード再設定リンク: #{edit_password_url(record, reset_password_token: token)}"
    )
    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    sg.client.mail._('send').post(request_body: mail.to_json)
  end
end
