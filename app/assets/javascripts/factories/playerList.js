angular.module("DiplomacyApp")
.factory('playerList', ['$http', function($http){
  var playerList = { 
    data: {
      players: [{name: 'Loading', total_score: ''}],
      isLoaded: false
    } 
  };

  playerList.loadPlayers = function(){
    $http.get('/players.json')
    .success(function(data){
    	playerList.data.players = data;
    	playerList.data.isLoaded = true;
      console.log('Successfully loaded player list.');
    })
    .error(function(){
      console.error('Failed to load player list.');
    });
	};

  playerList.addPlayer = function(newPlayer){
    if (newPlayer.name == ''){
      alert('Player name cannot be left blank.');
      return false
    };
    
    $http.post('/players.json', newPlayer)
    .success(function(data){
      playerList.data.players.push(data);
      console.log('Successfully created player.');
    })
    .error(function(){
      console.error('Failed to create player.');
    });
  };
	return playerList;
}]);