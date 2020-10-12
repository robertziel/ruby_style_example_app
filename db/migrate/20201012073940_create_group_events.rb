class CreateGroupEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :group_events do |t|
      t.string :state, null: false, default: GroupEvent::DRAFT

      t.date :start_date
      t.date :end_date
      t.integer :duration

      t.string :name
      t.text :description
      t.string :location

      t.timestamps
    end
  end
end
