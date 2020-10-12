class AddParanoidToGroupEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :group_events, :deleted_at, :datetime, index: true
  end
end
