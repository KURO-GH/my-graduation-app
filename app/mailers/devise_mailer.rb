# app/mailers/devise_mailer.rb
class DeviseMailer < Devise::Mailer
  default from: 'k.s06020608@gmail.com'
  layout 'mailer'
end
