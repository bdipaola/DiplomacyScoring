angular.module("DiplomacyApp", ['ngRoute'])
.config([
  '$routeProvider', function($routeProvider,$locationProvider) {
    $routeProvider
      .when('/', { templateUrl: '../assets/playersIndex.html', controller: 'PlayersIndexCtrl' } )
			.when('/players/:id', { templateUrl: '../assets/playerPage.html', controller: 'PlayerShowCtrl' } )
			.when('/players/:id/edit', { templateUrl: '../assets/editPlayer.html', controller: 'PlayerEditCtrl' } )	
			.when('/boards/:id', { templateUrl: '../assets/boardPage.html', controller: 'BoardShowCtrl' } )
			.when('/boards/:id/edit', { templateUrl: '../assets/editBoard.html', controller: 'BoardEditCtrl' } )			      
      .otherwise( {templateUrl: '../assets/playersIndex.html', controller: 'PlayersIndexCtrl'} );
  }
])
.config(["$httpProvider", function($httpProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}])