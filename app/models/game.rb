class Game < ActiveRecord::Base
	belongs_to :player
	belongs_to :board

	after_save do
		Player.calculate_scores
		Player.set_ranks
	end
end
