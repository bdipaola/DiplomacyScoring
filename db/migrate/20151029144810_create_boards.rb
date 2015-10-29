class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.integer :number
      t.string :location

      t.timestamps null: false
    end
  end
end
