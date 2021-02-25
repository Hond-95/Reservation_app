class CreateMigrations < ActiveRecord::Migration[6.1]
  def change
    create_table :migrations do |t|
      t.string :AddAreaToRoom
      t.string :status

      t.timestamps
    end
  end
end
