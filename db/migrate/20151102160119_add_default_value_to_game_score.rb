class AddDefaultValueToGameScore < ActiveRecord::Migration
  def change
  	change_column_default(:games, :score, 0.0000)
  end
end
