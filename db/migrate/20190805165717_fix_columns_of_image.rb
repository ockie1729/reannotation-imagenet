class FixColumnsOfImage < ActiveRecord::Migration[5.2]
  def change
    add_column :images, :cluster_no, :integer
    add_column :images, :fname, :string
    add_reference :images, :image_class, foreign_key: true

  end
end
