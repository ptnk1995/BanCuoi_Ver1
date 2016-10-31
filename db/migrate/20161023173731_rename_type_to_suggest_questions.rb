class RenameTypeToSuggestQuestions < ActiveRecord::Migration[5.0]
  def change
    rename_column :suggest_questions, :type, :pattern
  end
end
