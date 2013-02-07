class SessionsController < ApplicationController
  # todo: right now this whole process requires the user to re-auth if they've signed out
  # Maybe there is a way to let the user log in, wihtout having to authorize again?
  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    session[:access_token] = env['omniauth.auth']["extra"]["access_token"]
    redirect_to :root, notice: 'Signed in!'
  end

  def failure
    redirect_to :root, notice: 'There was an error while signing into Evernote.'
  end

  def destroy
    session.clear
    redirect_to :root, notice: 'Signed out.'
  end
end
