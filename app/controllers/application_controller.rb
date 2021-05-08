class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  helper_method :current_user

  def authenticate_user!
    if current_user.nil?
      redirect_to new_session_path, alert: 'Use must be signed in to perform action'
    end
  end

  private

    def current_user
      @current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
    end

    def handle_record_not_found
      render '404_page', status: 404
    end
end
