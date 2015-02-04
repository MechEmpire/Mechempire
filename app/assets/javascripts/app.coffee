receta = angular.module('receta',[
  'templates',
  'ngRoute',
  'controllers',
])

receta.config(['$routeProvider',
	($routeProvider) ->
		$routeProvider
			.when('/',
				templateUrl: "index.html"
				controller: 'IndexController'
			).when('/users',
				templateUrl: "user/user_list.html"
				controller: "UserController"
			)
])

controllers = angular.module('controllers',[])
controllers.controller("UserController", ['$scope','$routeParams','$location'
		($scope, $routeParams,$location)->
	])
controllers.controller("IndexController", ['$scope','$routeParams','$location'
		($scope, $routeParams,$location)->
	])