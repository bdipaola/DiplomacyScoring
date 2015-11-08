class Game < ActiveRecord::Base
	belongs_to :player
	belongs_to :board

	before_save do
		Player.calculate_scores
		Player.set_ranks
	end

end
