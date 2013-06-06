module UrlHelper
  def authorization_endpoint_url(client)
    parameters = {
      :client_id     => client.uid,
      :redirect_uri  => client.redirect_uri,
      :response_type => "code"
      }

    "/oauth/authorize?#{build_query(parameters)}"
  end

  def token_endpoint_url(options = {})
    parameters = {
      :code          => options[:code],
      :redirect_uri  => options[:client].redirect_uri,
      :client_id     => options[:client].uid,
      :client_secret => options[:client].secret,
      :grant_type    => "authorization_code"
      }

    "/oauth/token?#{build_query(parameters)}"
  end
end

RSpec.configuration.send :include, UrlHelper, :type => :request
