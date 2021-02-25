class AddDetailsToRoom < ActiveRecord::Migration[6.1]
  def change
    add_column :rooms, :user_id, :string
  end
end
