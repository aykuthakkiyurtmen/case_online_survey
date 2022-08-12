class BodyNullableTrue < ActiveRecord::Migration[6.1]
  def change
    change_column :responses, :body, :string, null: true
  end
end
