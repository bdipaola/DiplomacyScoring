class Player < ActiveRecord::Base
	has_many :games
	has_many :boards, through: :games

	before_save :set_default_total_score

	after_destroy do
		Player.set_ranks
	end

	def set_default_total_score
		self.assign_attributes(total_score: 0.00) if total_score.blank?
	end

	def self.calculate_scores
		Player.all.each do |player|
			player_game_scores = Game.where(player: player).map{ |game| game.score }
			player_game_scores.sort!{ |x,y| x<=>y }
			player.update(total_score: player_game_scores.first(3).reduce(:+))
		end
	end

	def self.set_ranks
		sorted_players = Player.order(total_score: :desc)
		sorted_players.each_with_index do |player, index|
			player.update(rank: index + 1)
		end
	end

	def player_games_hash(games) 
		player_hash = {
			id: self.id, 
			name: self.name,
			total_score: self.total_score,
			games: []
		}
		games.each { |game| player_hash[:games] << { center_count: game.center_count, score: game.score, country: game.country } }
		player_hash
	end

end
