class Project < ApplicationRecord

  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :bugs, dependent: :destroy
  belongs_to :creator, class_name: 'User', foreign_key:'manager_id'

  validates :title, presence: true, uniqueness: true
end
