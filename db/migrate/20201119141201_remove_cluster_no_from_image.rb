class RemoveClusterNoFromImage < ActiveRecord::Migration[5.2]
  def change
    remove_column :images, :cluster_no
  end
end
