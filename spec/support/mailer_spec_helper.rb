module MailerSpecHelper
  def should_receive_password_reset_email(user, redirect_uri='')
    Resque.should_receive(:enqueue).with(MailQueue,
           {:klass=>"Mailer", :method=>:password_reset,
                              :args=> [hash_including("email" => user.email, :redirect_uri => redirect_uri)]})
  end
end

RSpec.configuration.send :include, MailerSpecHelper
