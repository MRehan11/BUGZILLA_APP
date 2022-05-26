class Bug < ApplicationRecord

  belongs_to :project
  belongs_to :user
  belongs_to :creator, class_name: 'User', foreign_key:'qa_id'
  validates :title, presence: true, length: {minimum: 5, maximum: 50}
  validates :status, presence: true
  enum status: %i[new_ started in_progress completed]

  mount_uploader :screenshot, ImageUploader
  serialize :screenshot, JSON
end