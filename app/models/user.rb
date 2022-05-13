class User < ApplicationRecord
  has_many :created_projects, class_name: 'Project', foreign_key: 'manager_id'
  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :created_bugs, class_name: 'Bug', foreign_key: 'qa_id'
  has_many :bugs
  enum role: %i[developer manager qa]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
end
