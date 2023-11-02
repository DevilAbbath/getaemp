# == Schema Information
#
# Table name: jobs
#
#  id          :bigint           not null, primary key
#  job_title   :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
class Job < ApplicationRecord
  belongs_to :user
  has_many :job_applications, dependent: :destroy

  validates :job_title, presence: true, length: { minimum: 2, maximum: 50 }
  validates :description, presence: true, length: { minimum: 2, maximum: 2000 }
end
