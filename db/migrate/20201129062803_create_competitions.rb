class CreateCompetitions < ActiveRecord::Migration[5.2]
  def change
    create_table :competitions do |t|
      t.datetime :starts_at
      t.datetime :ends_at
      t.string :title
      t.text :text
      t.boolean :finished

      t.timestamps
    end
  end
end
