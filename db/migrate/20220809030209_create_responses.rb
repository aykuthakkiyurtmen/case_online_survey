class CreateResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :responses, id: :uuid do |t|
      t.string :body
      t.references :question, null: false, foreign_key: true, index: true, type: :uuid
      t.references :option, null: false, foreign_key: true, index: true, type: :uuid
      t.references :feedback, null: false, foreign_key: true, index: true, type: :uuid

      t.timestamps
    end
  end
end
