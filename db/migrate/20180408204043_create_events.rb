class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.string :widget_name
      t.string :user_type
      t.string :user_id
      t.json   :data, default: {}

      t.timestamps
    end
  end
end
