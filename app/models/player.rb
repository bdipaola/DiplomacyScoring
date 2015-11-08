class Player < ActiveRecord::Base
	has_many :games
	has_many :boards, through: :games

	before_save :set_default_rank

	after_destroy do
		Player.set_ranks
	end

	def set_default_rank
		player = Player.order(total_score: :asc).first
		count = Player.count
		if !player
			self.assign_attributes(rank: count + 1) if rank.blank?
		elsif player && (player.total_score === self.total_score)
			self.assign_attributes(rank: player.rank) if rank.blank?
		else
			self.assign_attributes(rank: player.rank + 1) if rank.blank?
		end
	end

	def self.calculate_scores
		Player.all.each do |player|
			player_game_scores = Game.where(player: player).map{ |game| game.score }
			player_game_scores.sort!{ |x,y| x<=>y }
			if player_game_scores.count
				player.update(total_score: player_game_scores.first(3).reduce(:+))
			else
				player.update(total_score: 0)
			end
		end
	end

	def self.set_ranks
		sorted_players = Player.order(total_score: :desc)
		reset_players_rank = sorted_players.each { |player| player.assign_attributes(rank: 0) }
		reset_players_rank.each_with_index do |player, index|
			if player.total_score == reset_players_rank[index - 1].total_score
				player.update(rank: reset_players_rank[index - 1].rank)
			else
				player.update(rank: reset_players_rank[index - 1].rank + 1)
			end
		end
	end

	def player_games_hash(games) 
		player_hash = {
			id: self.id, 
			name: self.name,
			total_score: self.total_score,
			games: []
		}
		games.each { |game| player_hash[:games] << { board_number: game.board.number, location: game.board.location, center_count: game.center_count, score: game.score, country: game.country } }
		player_hash
	end

end
