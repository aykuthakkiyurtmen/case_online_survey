class CreateOptions < ActiveRecord::Migration[6.1]
  def change
    create_table :options, id: :uuid do |t|
      t.string :title
      t.references :question, null: false, foreign_key: true, index: true, type: :uuid

      t.timestamps
    end
  end
end
