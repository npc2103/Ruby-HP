class ApplicationController < ActionController::Base
  # ログイン後のリダイレクト先を指定
  def after_sign_in_path_for(resource)
    stored_location_for(resource) || root_path
  end

  protected

  # ユーザー登録時にusernameの登録を許可する
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end
end
