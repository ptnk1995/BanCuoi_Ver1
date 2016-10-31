class RenameTypeToQuestions < ActiveRecord::Migration[5.0]
  def change
    rename_column :questions, :type, :pattern
  end
end
