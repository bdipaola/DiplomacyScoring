angular.module("DiplomacyApp", ['ngRoute'])
.config([
  '$routeProvider', function($routeProvider,$locationProvider) {
    $routeProvider
      .when('/', { templateUrl: '../assets/playersIndex.html', controller: 'PlayersIndexCtrl' } )
      .otherwise( {templateUrl: '../assets/playersIndex.html', controller: 'PlayersIndexCtrl'} );
  }
])