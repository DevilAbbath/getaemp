# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
  # Solo los admin pueden crear cuentas
  before_action :authenticate_user!, :redirect_unless_admin, only: %i[create new]
  # Linea para para evitar el user already log in
  skip_before_action :require_no_authentication

  private

  def user_params
    params.require(:user).permit(:email, :name, :profile_picture, :phone_number, :department, :position, :password,
                                 :password_confirmation, :current_password)
  end

  def redirect_unless_admin
    return if current_user && current_user.role == 'admin'

    flash[:error] = 'Only admins can do that'
    redirect_to jobs_path
  end

  # Metodo para evitar el logueo automatico de cuentas nuevas
  def sign_up(_resource_name, _resource)
    true
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[name email password password_confirmation role profile_picture])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[name email password password_confirmation current_password
                                               profile_picture phone_number department position ])
  end
end
