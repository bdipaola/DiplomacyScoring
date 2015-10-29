# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#list players
player_names = ["Jim O'Kelley", "Jake Trotta", "Ali Adib", "Brandon Fogel", "Brian Beck", "Josh Heffernan", "David Spanos", "Ray Trotta", "Matt Sunstrom", "Kevin O'Kelly", "Ryan Yates", "Carlos Trevino", "Andre Dankha", "David Kodeski", "Yash Niuam", "Geoff Serednesky", "Sean Clarke", "Chris Cantine", "Brad Harrington", "Amanda Baumgartner", "Don Glass", "Christian Kline", "Peter Lokken", "Kevin O'Kelley"]

#locations
locations = ["Red Lion", "Lokken House", "Guthrie's Tavern"]

#countries
countries = ["Austria", "England", "Russia", "Turkey", "France", "Italy", "Germany"]

#moves by country
austria_moves = ["F Tri - Alb, A Bud - Ser, A Vie - Bud", "F Tri - Alb, A Bud - Ser, A Vie - Tri", "F Tri - Alb, A Bud - Ser, A Vie - Gal", "F Tri - Hold, A Bud - Ser, A Vie - Bud", "F Tri - Alb, A Bud - Ser, A Vie - Hold"]
england_moves = ["F Edi - Nwg, F Lon - Nth, A Lvp - Edi", "F Edi - Nwg, F Lon - Nth, A Lvp - Yor", "F Edi - Nth, F Lon - Eng, A Lvp - York", "F Edi - Nth, F Lon - Eng, A Lvp - Wal", "F Edi - Nwg, F Lon - Eng, A Lvp - Wal"]
france_moves = ["F Bre - Mao, A Mar - S Par-Bur, A Par - Bur", "F Bre - Mao, A Mar - Spa, A Par - Bur", "F Bre - Mao, A Mar - Spa, A Par - Pic", "F Bre - Mao, A Mar - Hold, A Par - Pic", "F Bre - Eng, A Mar - Spa, A Par - Bur"]
germany_moves = ["F Kie - Hol, A Ber - Kie, A Mun - Ruh", "F Kie - Den, A Ber - Kie, A Mun - Ruh", "F Kie - Hol, A Ber - Kie, A Mun - Bur", "F Kie - Den, A Ber - Kie, A Mun - Hold", "F Kie - Den, A Ber - Kie, A Mun - Bur"]
italy_moves = ["A Rom - Ven, F Nap - Ion, A Ven - Tyr", "A Rom - Apu, F Nap - Ion, A Ven - Hold", "A Rom - Apu, F Nap - Ion, A Ven - Tyr", "A Rom - Ven, F Nap - Ion, A Ven - Pie", "A Rom - Apu, F Nap - Ion, A Ven - Tri"]
russia_moves = ["A Mos - Ukr, A War - Gal, F StP(sc) - Bot, F Sev - Rum", "A Mos - Ukr, A War - Gal, F StP(sc) - Bot, F Sev - Bla", "A Mos - StP, A War - Ukr, F StP(sc) - Bot, F Sev - Bla", "A Mos - StP, A War - Ukr, F StP(sc) - Bot, F Sev - Rum", "A Mos - Sev, A War - Ukr, F StP(sc) - Bot, F Sev - Rum"]
turkey_moves = ["A Con - Bul, F Ank - Bla, A Smy - Con", "A Con - Bul, F Ank - Con, A Smy - Hold", "A Con - Bul, F Ank - Bla, A Smy - Arm", "A Con - Bul, F Ank - Con, A Smy - Ank", "A Con - Bul, F Ank - Con, A Smy - Arm"]

#nested move array
moves = [austria_moves, england_moves, russia_moves, turkey_moves, france_moves, italy_moves, germany_moves]

#create boards
4.times do |count|
	Board.create!(number: count + 1, location: locations.sample)
end

#create players
player_names.each do |player|
	Player.create!(name: player)
end

#create player sets for games, each player's center count, country, and open_move
Board.all.each do |board|
	player_set = []
	center_count = 0
	centers_remain = 27
	player_names.shuffle!
	player_set = player_names.slice(0,6)
	
	player_set.each_with_index do |player, index|
		add_centers = centers_remain >= 17 ? rand(0..17) : rand(0..centers_remain)
		center_count += (add_centers + 1)

		countries.shuffle!
		player_record = Player.find_by(name: player)
		Game.create!(board_id: board.id, player_id: player_record.id, center_count: center_count, country: countries[index], open_move: moves[index][rand(0..4)])
		centers_remain -= add_centers
	end
end

#creating score for each player
Board.all.each do |board|
	sum_of_squares = Game.where(board_id: board.id).map{ |game| game.center_count }.reduce(:+)
	board.players.each do |player|
		game_record = Game.find_by(board_id: board.id, player_id: player.id)
		game_record.update(score: game_record.center_count ** 2 / sum_of_squares)
	end
end


