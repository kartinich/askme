class ApplicationController < ActionController::Base
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def reject_user
    redirect_to root_path, alert: 'Вам сюда низя!'
  end

  def already_log_in
    redirect_to root_path, alert: 'Вы уже залогинены' if current_user.present?
  end
end
