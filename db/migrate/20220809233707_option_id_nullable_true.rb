class OptionIdNullableTrue < ActiveRecord::Migration[6.1]
  def change
    change_column :responses, :option_id, :uuid, null: true
  end
end
