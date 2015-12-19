angular.module("DiplomacyApp")
.factory('boardShow', ['$http', '$location', function($http, $location){
  
  var boardData = { 
    data: { 
      board_number: 'Loading', board_location: 'Loading', players: [], 
      isLoaded: false 
    }
  };

  boardData.loadBoard = function(boardId){
    $http.get('/boards/' + boardId + '.json')
    .success(function(data){
    	boardData.data = data;
    	boardData.data.isLoaded = true;
      console.log('Successfully loaded board and player data.');
    })
    .error(function(){
      console.error('Failed to load board and player data.');
    });
	}

  boardData.updateBoard = function(boardData) {
    $http.put('/boards/' + boardData.board_number + '.json', boardData)
    .then(function(data){
      console.log("Successfully updated board.")
      $location.url('/boards/' + boardData.board_number);
    },
    function(){
      console.error('Failed to update board.');
    });
  }

  return boardData;
}]);