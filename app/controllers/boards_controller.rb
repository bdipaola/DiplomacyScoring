class BoardsController < ApplicationController
	include PlayersHelper
	include GamesHelper

	def show
		game_records = Game.where(board_id: params[:id])
		players = Board.find(params[:id]).players

		player_games = create_game_players_hash(create_players_hash(players), create_games_hash(game_records))		

		respond_to do |format|
      format.json { render json: player_games }
    end
	end

end
