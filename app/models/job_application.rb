# == Schema Information
#
# Table name: job_applications
#
#  id         :bigint           not null, primary key
#  user_id    :bigint           not null
#  job_id     :bigint           not null
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class JobApplication < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validates :message, presence: true, length: { minimum: 2, maximum: 500 }
  validates :user_id, uniqueness: { scope: :job_id, message: 'Ya te has postulado a este trabajo' }
end
