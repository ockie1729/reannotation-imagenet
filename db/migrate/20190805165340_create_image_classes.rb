class CreateImageClasses < ActiveRecord::Migration[5.2]
  def change
    create_table :image_classes do |t|
      t.boolean :annotated
      t.references :team, foreign_key: true
      t.string :tag
      t.string :reference_page_url

      t.timestamps
    end
  end
end
