class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :player_id
      t.integer :board_id
      t.integer :center_count
      t.float :score
      t.string :country
      t.string :open_move

      t.timestamps null: false
    end
  end
end
