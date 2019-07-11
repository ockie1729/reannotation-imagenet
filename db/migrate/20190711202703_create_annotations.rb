class CreateAnnotations < ActiveRecord::Migration[5.2]
  def change
    create_table :annotations do |t|
      t.references :image, index: true
      t.string :label, null: false

      t.timestamps
    end
  end
end
