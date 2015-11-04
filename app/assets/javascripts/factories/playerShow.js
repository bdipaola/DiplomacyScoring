angular.module("DiplomacyApp")
.factory('playerShow', ['$http', function($http){
  
  var playerData = { 
    data: {
      player: [{name: 'Loading', total_score: ''}],
      isLoaded: false
    } 
  };

  playerData.loadPlayer = function(playerId){
    $http.get('/players/' + playerId + '.json')
    .success(function(data){
    	playerData.data.player = data;
    	playerData.data.isLoaded = true;
      console.log('Successfully loaded player data.');
    })
    .error(function(){
      console.error('Failed to load player data.');
    })
	};

  playerData.updatePlayer = function(playerData){
    $http.put('/players/' + playerData.id + '.json', playerData)
    .success(function(data){
      console.log(data);
      console.log("update got here!")
    })
    .error(function(){
      console.error('Failed to update data.');
    })
  };

	return playerData;
}]);