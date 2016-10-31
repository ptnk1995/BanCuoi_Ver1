class CreateAnswerChooses < ActiveRecord::Migration[5.0]
  def change
    create_table :answer_chooses do |t|
      t.boolean :is_correct
      t.references :question_exam, foreign_key: true
      t.references :answer, foreign_key: true

      t.timestamps
    end
  end
end
