class BoardsController < ApplicationController
	def index
	end

	def show
		board = Board.find(params[:id])
		game_records = Game.where(board_id: params[:id])
		players = board = Board.find(params[:id]).players
		
	
		nested_games_data = board.board_hash(games)

		respond_to do |format|
      format.json { render json: nested_player_data }
    end
	end

end
