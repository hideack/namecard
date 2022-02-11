module AuthHelper
  SITE = 'https://suzuri.jp/'
  AUTHORIZE_URL = '/oauth/authorize'
  TOKEN_URL = '/oauth/token'
  SCOPES = ['k:app_record:read', 'k:app_record:write']
  STATE = SecureRandom.alphanumeric

  def get_login_url
    client = OAuth2::Client.new(
      ENV['CLIENT_ID'],
      ENV['CLIENT_SECRET'],
      :site => SITE,
      :authorize_url => AUTHORIZE_URL,
      :token_url => TOKEN_URL
    )

    login_url = client.auth_code.authorize_url(
      :redirect_uri => authorize_url,
      :scope => SCOPES.join(' '),
      :state => STATE
    )
  end

  def get_token_from_code(auth_code)
    client = OAuth2::Client.new(
      CLIENT_ID,
      CLIENT_SECRET,
      :site => SITE,
      :authorize_url => AUTHORIZE_URL,
      :token_url => TOKEN_URL
    )

    token = client.auth_code.get_token(
      auth_code,
      :redirect_uri => authorize_url,
      :scope => SCOPES.join(' ')
    )
  end

  def get_access_token
    token_hash = session[:suzuri_token]

    client = OAuth2::Client.new(
      CLIENT_ID,
      CLIENT_SECRET,
      :site => SITE,
      :authorize_url => AUTHORIZE_URL,
      :token_url => TOKEN_URL
    )

    token = OAuth2::AccessToken.from_hash(client, token_hash)

    if token.expired?
      new_token = token.refresh!
      session[:suzuri_token] = new_token.to_hash
      access_token = new_token
    else
      access_token = token
    end
end
