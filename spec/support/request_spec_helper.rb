module RequestSpecHelper
  def i_should_be_on_client_app
    current_host.should eq "http://fakewebfoo.com"
  end

  def omniauth_facebook_driver
    OmniAuth.config.add_mock(:facebook, {:uid => '12345'})
    page.driver.request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:facebook]
  end

  def build_query(hash)
    Rack::Utils.build_query(hash)
  end
end

RSpec.configuration.send :include, RequestSpecHelper, :type => :request
