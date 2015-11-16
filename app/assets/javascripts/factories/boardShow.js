angular.module("DiplomacyApp")
.factory('boardShow', ['$http', '$location', function($http, $location){
  
  var boardData = { data: { board_number: 'Loading', board_location: 'Loading', players: [] }, isLoaded: false };

  boardData.loadBoard = function(boardId){
    $http.get('/boards/' + boardId + '.json')
    .success(function(data){
    	boardData.data = data;
    	boardData.isLoaded = true;
      console.log('Successfully loaded board and player data.');
    })
    .error(function(){
      console.error('Failed to load board and player data.');
    });
	}
  return boardData;
}]);