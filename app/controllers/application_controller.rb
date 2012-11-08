class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_access_token

  protected
  def access_token
    cookies[:access_token]
  end

  def access_granted?
    !AccessToken.current.nil?
  end

  def kpoint_host
    APP_CONFIG["kpoint_host"]
  end

  def oauth_client_id
    APP_CONFIG["client_id"]
  end

  def access_denied?
    cookies[:access_denied] == "true"
  end

  def requires_oauth_access_token
    (render :status => :forbidden, :text => "Forbidden") and return if access_denied?
    return if access_granted?
    redirect_url = callback_url
    cookies[:requested_url] = request.fullpath
    redirect_to("https://#{kpoint_host}/api/v1/oauth2/authorize?response_type=token&client_id=#{oauth_client_id}&redirect_uri=#{URI.encode(redirect_url)}")
  end

  private
  def set_access_token
    AccessToken.current = (access_token.nil? ? nil : AccessToken.new(access_token))
  end
end
