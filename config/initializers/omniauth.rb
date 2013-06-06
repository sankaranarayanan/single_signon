OmniAuth.config.form_css = ENV['CUSTOM_CSS']
Rails.application.config.middleware.use OmniAuth::Builder do
  provider  :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider  :google_oauth2, ENV['GOOGLE_KEY'], ENV['GOOGLE_SECRET'], {access_type: 'online', approval_prompt: ''}
  provider  :identity,
            :fields => [:email, :password],
            :form => true,
            :on_failed_registration => lambda { |env| SessionsController.action(:failure).call(env) }
end
