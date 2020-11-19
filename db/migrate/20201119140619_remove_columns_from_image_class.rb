class RemoveColumnsFromImageClass < ActiveRecord::Migration[5.2]
  def change
    remove_column :image_classes, :team_id
    remove_column :image_classes, :annotated
  end
end
