class AddUserToAnnotations < ActiveRecord::Migration[5.2]
  def change
    add_reference :annotations, :user, foreign_key: true
  end
end
