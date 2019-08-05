class AddTeamIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :users, :team
  end
end
