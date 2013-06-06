ActionMailer::Base.register_interceptor(SendGrid::MailInterceptor)

ActionMailer::Base.smtp_settings = {
  :address => 'smtp.sendgrid.net',
  :port => '25',
  :authentication => :plain,
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD']
}

if Rails.env.development? || Rails.env.test?
  ActionMailer::Base.default_url_options = {:host => 'localhost:3000'}
else
  ActionMailer::Base.default_url_options = {:host => ENV['HOST']}
end
