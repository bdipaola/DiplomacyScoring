module PlayersHelper
	def create_players_hash(players_record)
		players = []

		players_record.each do |player|
			players << { player_id: player.id, player_name: player.name }
		end

		players.sort! { |x, y| x["player_id"] <=> y["player_id"] }
	end

	def players_new_score_hash(players)
		hash = {}
		sum_of_squares = players.map{ |player| player[:center_count].to_i ** 2 }.reduce(:+) 
		
		players.each do |player|
			player_centers_squared = player[:center_count].to_i ** 2
			squared_score_for_game = player_centers_squared / sum_of_squares.to_f
			normalized_score_for_game = (squared_score_for_game * 100).round(4)
			hash[player[:player_name]] = normalized_score_for_game
		end
		hash
	end
end
