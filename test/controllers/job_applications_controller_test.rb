require 'test_helper'

class JobApplicationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    # Se debe usar un user que no tenga el role de admin
    @user = users(:two)
    @job = jobs(:three)
  end

  # test probara todo el flujo desde apertura de la app, el login y la creación de una application
  test 'user flow to create a new application to a job' do
    # Entramos a la application y hacemos click en el link para iniciar session
    visit root_path

    # Verifico si estoy en la pagina de login para poder trabajar con el formulario
    click_link 'iniciar sesión'
    assert current_path == new_user_session_path

    # Rellenamos el formulario de login
    fill_in('user_email', with: @user.email)
    fill_in('user_password', with: '123456')
    click_on 'Log in'

    # Comprobamos que la session se inicie con éxito y que estemos en la paginas de jobs
    assert_text 'Signed in successfully.'
    assert current_path == jobs_path

    # Nos dirigimos a la pagina del trabajo @job para postular
    click_link "job_#{@job.id}_link"
    assert_current_path job_path(@job)

    # Nos aseguramos que podemos postular y esto solo pasara si encontramos la form
    assert_no_text 'Ya te has postulado a esta oferta de trabajo.'
    page.assert_selector('form', text: 'Deja tu mensaje para postular')
    fill_in('job_application_message', with: 'Me encuentro postulando a esta nueva oportunidad laboral')

    # Completamos la postulación
    click_on 'Application'
    assert_text 'Tu postulación ha sido enviada con éxito.'

    # Finalmente comprobamos que ya estamos postulando
    assert_current_path job_path(@job)
    assert_text 'Ya te has postulado a esta oferta de trabajo.'
    assert_no_selector('form', text: 'Deja tu mensaje para postular')
  end
end
