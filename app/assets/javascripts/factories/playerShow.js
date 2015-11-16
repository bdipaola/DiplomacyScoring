angular.module("DiplomacyApp")
.factory('playerShow', ['$http', '$location', function($http, $location){
  
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
    });
	};

  playerData.updatePlayer = function(playerData){
    $http.put('/players/' + playerData.id + '.json', playerData)
    .then(function(data){
      console.log("Successfully updated record.")
      $location.url('/players/' + data.data.id);
    },
    function(){
      console.error('Failed to update data.');
    });
  };

  playerData.deletePlayer = function(playerId){
    $http.delete('/players/' + playerId + '.json')
    .then(function(data){
      console.log('Successfully deleted record.');
      $location.url('/');
    },
    function(){
      console.error('Failed to delete record.');
    });
  }
  
	return playerData;
}]);