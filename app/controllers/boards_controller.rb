class BoardsController < ApplicationController
	include PlayersHelper
	include GamesHelper

	def show
		board = Board.find_by(number: params[:id])
		players = Board.find(params[:id]).players
		game_records = Game.where(board_id: params[:id])
		
		player_games = create_game_players_hash(create_players_hash(players), create_games_hash(game_records))		
		game_data = board.create_complete_board_data(player_games)
		
		respond_to do |format|
      format.json { render json: game_data }
    end
	end

	def update
		board = Board.find(params[:board_number])
		players = params[:players]

		new_scores = players_new_score_hash(players)
		players.each do |player|
			game_record = Game.find_by(player_id: player[:player_id])
			game_record.update(country: player[:country], center_count: player[:center_count], open_move: player[:open_move], score: new_scores[player[:player_name]]) 
		end

		board.update(location: params[:board_location])

		respond_to do |format|
      format.json { render json: board }
    end
	end

end
