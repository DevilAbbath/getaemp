# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  profile_picture        :string
#  name                   :string
#  role                   :string           not null
#  phone_number           :string
#  department             :string
#  position               :string
#
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Relations
  has_one_attached :profile_picture
  has_many :jobs, dependent: :destroy
  has_many :job_applications, dependent: :destroy

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :role, presence: true
  
  # Roles
  enum role: { user: 'user', admin: 'admin' }
end
