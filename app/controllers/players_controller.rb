class PlayersController < ApplicationController
	def index
		players = Player.all
		respond_to do |format|
      format.json { render json: players }
    end
	end

	def show
		player = Player.find(params[:id])
		games = Game.where(player_id: player.id)
		nested_player_data = player.player_games_hash(games)

		respond_to do |format|
      format.json { render json: nested_player_data }
    end
	end

end