class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions, id: :uuid do |t|
      t.string :title
      t.integer :type
      t.references :survey, null: false, foreign_key: true, index: true, type: :uuid

      t.timestamps
    end
  end
end
