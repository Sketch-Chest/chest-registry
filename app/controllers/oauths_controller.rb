# Those codes are almost based on:
# http://www.gotealeaf.com/blog/adding-oauth-login-via-github-to-an-existing-app-using-the-sorcery-gem
# https://github.com/NoamB/sorcery/wiki/External

class OauthsController < ApplicationController
  skip_before_filter :require_login

  # let the user get trip to the provider,
  # and after authorizing there back to the #callback below
  def oauth
    login_at(auth_params[:provider])
  end

  # this is where all of the magic happens
  def callback
    # this will be set to 'github' when user is logging in via Github
    provider = auth_params[:provider]

    if @user = login_from(provider)
      # user has already linked their account with github
      redirect_to root_path, notice: "Logged in using #{provider.titleize}!"
    else
      # User has not linked their account with Github yet. If they are logged in,
      # authorize the account to be linked. If they are not logged in, require them
      # to sign in. NOTE: If you wanted to allow the user to register using oauth,
      # this section will need to be changed to be more like the wiki page that was
      # linked earlier.
      begin
        @user = create_from(provider)
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule

        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to root_path, notice: "Logged in from #{provider.titleize}!"
      rescue
        redirect_to root_path, alert: "Failed to login from #{provider.titleize}!"
      end
    end
  end

  # This is used to allow users to unlink their account from the oauth provider.

  # In order to use this action you will need to include this route in your routes file:
  # delete "oauth/:provider" => "oauths#destroy", :as => :delete_oauth

  # You will need to provide a 'provider' parameter to the action, create a link like this:
  # link_to 'unlink', delete_oauth_path('github'), method: :delete
  def destroy
    provider = auth_params[:provider]

    authentication = current_user.authentications.find_by_provider(provider)
    if authentication.present?
      authentication.destroy
      flash[:notice] = "You have successfully unlinked your #{provider.titleize} account."
    else
      flash[:alert] = "You do not currently have a linked #{provider.titleize} account."
    end

    redirect_to root_path
  end

  private
  def auth_params
    params.permit(:code, :provider)
  end
end
