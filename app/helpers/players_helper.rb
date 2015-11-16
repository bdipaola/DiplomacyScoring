module PlayersHelper
	def create_players_hash(players_record)
		players = []

		players_record.each do |player|
			players << { player_id: player.id, player_name: player.name }
		end

		players.sort! { |x, y| x["player_id"] <=> y["player_id"] }
	end
end
