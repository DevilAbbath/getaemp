class JobApplicationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_job, only: %i[new show create]

  def index
    @job_applications = current_user.job_applications
  end

  def new
    @job_application = @job.job_applications.new
  end

  def show
    @job_applications = @job.job_applications
  end

  def show_user
    @job_application = JobApplication.find(params[:id])
    @user = @job_application.user
  end

  def create
    @job_application = @job.job_applications.new(job_application_params)
    @job_application.user = current_user

    if @job_application.save
      flash[:notice] = 'Tu postulación ha sido enviada con éxito.'
      redirect_to @job
    else
      flash[:notice] = 'Ya te has postulado a este trabajo con anterioridad'
      redirect_to root_path
    end
  end

  private

  def set_job
    @job = Job.find(params[:job_id])
  end

  def job_application_params
    params.require(:job_application).permit(:message)
  end
end
