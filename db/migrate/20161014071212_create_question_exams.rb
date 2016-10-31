class CreateQuestionExams < ActiveRecord::Migration[5.0]
  def change
    create_table :question_exams do |t|
      t.boolean :is_correct
      t.references :question, foreign_key: true
      t.references :exam, foreign_key: true

      t.timestamps
    end
  end
end
