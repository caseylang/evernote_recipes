class SessionsController < ApplicationController
  # todo: right now this whole process requires the user to re-auth if they've signed out
  # Maybe there is a way to let the user log in, wihtout having to authorize again?
  def new
    begin
      session[:request_token] = client.authentication_request_token(:oauth_callback => sessions_create_url)
      redirect_to session[:request_token].authorize_url
    rescue => e
      logger.fatal "\nError: Failed to obtain temporary credentials. #{e.message}"
      flash[:error] = "There was an error while signing in to Evernote."
      redirect_to :root
    end
  end

  def create
    if params['oauth_verifier'] && session['request_token']
      session[:oauth_verifier] = params['oauth_verifier']
      begin
        session[:access_token] = session[:request_token].get_access_token(:oauth_verifier => session[:oauth_verifier])
        flash[:success] = "Account authorized!"
      rescue => e
        logger.fatal "\nError: Error extracting access token"
        flash[:error] = "There was an error while signing in to Evernote."
      end
    else
      logger.fatal "\nError: Content owner did not authorize the temporary credentials"
      flash[:error] = "You must grant access to your account in order to use Evernote Recipes"
    end

    redirect_to :root
  end

  def destroy
    session.clear
    redirect_to :root
  end
end
