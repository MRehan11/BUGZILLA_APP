class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.datetime :start_date
      t.integer :status
      t.text :screenshot
      t.references :project, foreign_key: true, index: true
      t.references :qa, foreign_key: {to_table: :users}, index: true

      t.timestamps
    end
  end
end
