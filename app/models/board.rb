class Board < ActiveRecord::Base
	has_many :games
	has_many :players, through: :games

	def create_complete_board_data(player_games)
		board_info = { board_number: self.number, board_location: self.location, players: player_games }
	end
end
