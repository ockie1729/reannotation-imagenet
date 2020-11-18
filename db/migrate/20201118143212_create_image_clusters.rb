class CreateImageClusters < ActiveRecord::Migration[5.2]
  def change
    create_table :image_clusters do |t|
      t.references :team, foreign_key: true
      t.references :image_class, foreign_key: true

      t.boolean :assigned, default: false
      t.datetime :assigned_at
      
      t.boolean :annotated, default: false
      t.datetime :annotated_at

      t.timestamps
    end
  end
end
