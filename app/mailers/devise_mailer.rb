class DeviseMailer < Devise::Mailer
  default from: 'k.s06020608@gmail.com'
  layout 'mailer'

  # Devise の reset_password_instructions をオーバーライド
  def reset_password_instructions(record, token, opts = {})
    @token = token
    @resource = record
    opts[:subject] ||= "パスワード再設定"

    # Rails 標準の mail メソッドで送信
    mail(to: record.email, subject: opts[:subject]) do |format|
      format.html { render 'devise/mailer/reset_password_instructions' }
    end
  end
end
