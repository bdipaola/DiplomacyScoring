angular.module("DiplomacyApp")
.factory('playerList', ['$http', function($http){
  var playerList = { 
    data: {
      players: [{name: 'Loading', total_score: ''}],
      isLoaded: false
    } 
  };

  playerList.loadPlayers = function(){
    $http.get('./players.json')
    .success(function(data){
    	playerList.data.players = data;
    	playerList.data.isLoaded = true;
      console.log('Successfully loaded player list.');
    })
    .error(function(){
      console.error('Failed to load player list.');
    })
	};
	return playerList;
}]);