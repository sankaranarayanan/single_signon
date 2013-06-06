class Authorization
  attr_accessor :current_user, :params, :authorization

  def initialize(user, attributes = {})
    @params = attributes
    @current_user = user
  end

  def authorization
    @authorization ||= Doorkeeper::OAuth::AuthorizationRequest.new(client, current_user, params).authorize
  end

  def grant_token
    Doorkeeper::OAuth::AccessTokenRequest.new(client,
          :code          => authorization.token,
          :redirect_uri  => params[:redirect_uri],
          :client_id     => client.uid,
          :grant_type    => "authorization_code"
    ).authorize
  end

  def client
    @client ||= Doorkeeper::OAuth::Client.find(params[:client_id])
  end
end
