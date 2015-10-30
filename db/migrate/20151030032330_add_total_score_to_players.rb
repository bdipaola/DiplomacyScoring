class AddTotalScoreToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :total_score, :float
  end
end
