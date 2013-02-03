module SessionsHelper
  # todo: most of this probably doesn't belong here. Move it.
  def signed_in?
    !!session[:access_token]
  end

  # todo: A user can revoke our access at anytime. Handle that.
  def auth_token
    session[:access_token].token if session[:access_token]
  end

  def client
    @client ||= EvernoteOAuth::Client.new
  end

  def user_store
    @user_store ||= client.user_store
  end

  def current_user
    @current_user ||= user_store.getUser(auth_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end