class CreateSurveys < ActiveRecord::Migration[6.1]
  def change
    create_table :surveys, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
    add_index :surveys, :name, unique: true
  end
end
