json.extract! job, :id, :job_title, :description, :created_at, :updated_at
json.url job_url(job, format: :json)
