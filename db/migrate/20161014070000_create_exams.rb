class CreateExams < ActiveRecord::Migration[5.0]
  def change
    create_table :exams do |t|
      t.integer :status
      t.integer :mark
      t.datetime :started_at
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :exams, [:user_id, :created_at]
  end
end
