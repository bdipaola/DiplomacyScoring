class Game < ActiveRecord::Base
	validates :player, uniqueness: true
	belongs_to :player
	belongs_to :board
end
