require 'sendgrid-ruby'
include SendGrid

SENDGRID_API_KEY = ENV.fetch('SENDGRID_API_KEY')
