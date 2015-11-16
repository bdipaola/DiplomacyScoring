class BoardsController < ApplicationController
	include PlayersHelper
	include GamesHelper

	def show
		board = Board.find_by(number: params[:id])
		game_records = Game.where(board_id: params[:id])
		players = Board.find(params[:id]).players

		player_games = create_game_players_hash(create_players_hash(players), create_games_hash(game_records))		
		game_data = board.create_complete_board_data(player_games)
		
		respond_to do |format|
      format.json { render json: game_data }
    end
	end

end
