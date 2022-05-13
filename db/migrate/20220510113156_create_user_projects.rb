class CreateUserProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :user_projects do |t|
      t.references :user, foreign_key: true, index: true
      t.references :project, foreign_key: true, index: true

      t.timestamps
    end
  end
end
