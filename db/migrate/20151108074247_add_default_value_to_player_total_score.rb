class AddDefaultValueToPlayerTotalScore < ActiveRecord::Migration
  def change
  	change_column_default(:players, :total_score, 0.0000)
  end
end
