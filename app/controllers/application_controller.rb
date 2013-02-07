class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper

  # todo: most of this probably doesn't belong here. Move it.
  # todo: A user can revoke our access at anytime. Handle that.
  def client
    @client ||= EvernoteOAuth::Client.new token: auth_token
  end

  def user_store
    @user_store ||= client.user_store
  end

  def note_store
    @note_store ||= client.note_store
  end

  def notebooks
    @notebooks ||= note_store.listNotebooks(auth_token)
  end

  def signed_in?
    !!(current_user && auth_token)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def auth_token
    session[:access_token].token if session[:access_token]
  end

  helper_method :current_user, :signed_in?
end
