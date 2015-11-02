angular.module("DiplomacyApp", ['ngRoute'])
.config([
  '$routeProvider', function($routeProvider,$locationProvider) {
    $routeProvider
      .when('/', { templateUrl: '../assets/playersIndex.html', controller: 'PlayersIndexCtrl' } )
			.when('/players/:id', { templateUrl: '../assets/playerPage.html', controller: 'PlayerShowCtrl' } )      
      .otherwise( {templateUrl: '../assets/playersIndex.html', controller: 'PlayersIndexCtrl'} );
  }
])
.config(["$httpProvider", function($httpProvider) {
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
}])