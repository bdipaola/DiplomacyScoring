module GamesHelper
	def create_games_hash(games_record)
		games = []
		games_record.each do |game|
			games << { player_id: game.player_id, board_id: game.board_id, center_count: game.center_count, score: game.score, country: game.country, open_move: game.open_move }
		end
		games.sort! { |x, y| x["player_id"] <=> y["player_id"] }
	end

	def create_game_players_hash(player_records, game_records)
		game_players = []
		player_records.each_with_index do |player, index|
			game_players << player.merge(game_records[index])
		end
		game_players
	end
end
