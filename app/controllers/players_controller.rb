class PlayersController < ApplicationController
	def index
		players = Player.order('total_score DESC, name')
		respond_to do |format|
      format.json { render json: players }
    end
	end

	def create
		player = Player.new(name: params[:player][:name])

		if player.valid?
      player.save!
    else
      render "public/422", :status => 422
      return
    end

		respond_to do |format|
      format.json { render json: player }
    end
	end

	def show
		player = Player.find(params[:id])
		games = Game.where(player_id: player.id)
		nested_player_data = player.player_games_hash(games)
		p nested_player_data

		respond_to do |format|
      format.json { render json: nested_player_data }
    end
	end

	def update
		player = Player.find(params[:id])
		player.update(name: params[:player][:name])
		respond_to do |format|
      format.json { render json: player }
    end
	end

	def destroy
		player = Player.find(params[:id])
		player.destroy
		respond_to do |format|
      format.json { render json: player }
    end
	end

	private
	def player_params
		params.require(:player).permit(:name)
	end


end
