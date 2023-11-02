require 'test_helper'

class JobsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @job = jobs(:one)
    @admin_user = users(:one)
    sign_in @admin_user
  end

  test 'should get index' do
    get jobs_url
    assert_response :success
  end

  test 'should get new' do
    get new_job_url
    assert_response :success
  end

  test 'should create job' do
    assert_difference('Job.count') do
      post jobs_url, params: { job: { description: @job.description, job_title: @job.job_title } }
    end

    assert_redirected_to job_url(Job.last)
  end

  test 'should show job' do
    get job_url(@job)
    assert_response :success
  end

  test 'should get edit' do
    get edit_job_url(@job)
    assert_response :success
  end

  test 'should update job' do
    patch job_url(@job), params: { job: { description: @job.description, job_title: @job.job_title } }
    assert_redirected_to job_url(@job)
  end

  test 'should destroy job' do
    assert_difference('Job.count', -1) do
      delete job_url(@job)
    end

    assert_redirected_to jobs_url
  end
end
