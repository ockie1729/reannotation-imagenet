class ChangeColumnToImageClass < ActiveRecord::Migration[5.2]
  def up
    change_column :image_classes, :annotated, :boolean,
                  null: false, default: false
  end

  def down
    change_column :image_classes, :annotated, :boolean
  end
end
