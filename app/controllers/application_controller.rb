class ApplicationController < ActionController::Base

    before_action :configure_permited_paramaters, if: :devise_controller?

    def authenticate_admin!
        redirect_to new_user_session_path unless (!current_user.nil? && current_user.admin)
    end
    

    protected
    def configure_permited_paramaters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :photo_url])
    end
    

end
