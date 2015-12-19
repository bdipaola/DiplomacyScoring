class Game < ActiveRecord::Base
	belongs_to :player
	belongs_to :board

	after_save do
		Player.calculate_scores
		Player.set_ranks
	end

	def calculate_game_scores(board_id)
		sum_of_squares = Game.where(board_id: board_id).map{ |game| game.center_count ** 2 }.reduce(:+)
		players = Board.find(board_id).players

		players.each do |player|
			game_record = Game.find_by(board_id: board_id, player_id: player.id)
	
			player_centers_squared = game_record.center_count ** 2
			squared_score_for_game = player_centers_squared / sum_of_squares.to_f
			normalized_score_for_game = (squared_score_for_game * 100).round(4)
		
			game_record.update(score: normalized_score_for_game)
		end		
	end

end
