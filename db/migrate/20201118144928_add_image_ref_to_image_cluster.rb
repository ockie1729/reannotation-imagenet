class AddImageRefToImageCluster < ActiveRecord::Migration[5.2]
  def change
    add_reference :images, :image_cluster, foreign_key: true
  end
end
