class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.string :url
      t.boolean :annotated, default: false, null: false

      t.timestamps
    end
  end
end
