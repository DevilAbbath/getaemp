class ApplicationController < ActionController::Base
  before_action :redirect_to_jobs

  private

  # Redirijo al usuario a jobs_path una vez haya logrado hacer log in
  def after_sign_in_path_for(_resource)
    jobs_path
  end

  # Si un usuario logueado trata de ir al root_path (imagen + login) es redirecionado a jobs_path
  def redirect_to_jobs
    return unless user_signed_in? && request.path == root_path

    redirect_to jobs_path
  end
end
