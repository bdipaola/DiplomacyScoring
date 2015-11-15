class Board < ActiveRecord::Base
	has_many :games
	has_many :players, through: :games

	def game_hash
		#what i want:
		# board number, board location
		# all player names
		# corresponding player centers, scores, country and opening move 
	end
end
