class Project < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key:'manager_id'
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
  has_many :bugs, dependent: :destroy
  validates :title, presence: true, uniqueness: true
end
