class CreateSuggestQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :suggest_questions do |t|
      t.text :content
      t.boolean :status
      t.integer :type
      t.references :user, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
    add_index :suggest_questions, [:user_id, :created_at]
  end
end
