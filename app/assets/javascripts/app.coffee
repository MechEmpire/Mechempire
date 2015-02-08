#= require_self
#= require_tree ./templates
#= require_tree ./controllers

mechempire = angular.module('mechempire',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers'
])

mechempire.config(['$routeProvider',
	($routeProvider) ->
		$routeProvider
			.when('/',
				templateUrl: "index.html"
				controller: 'IndexController'
			).when('/users',
				templateUrl: "user/user_list.html"
				controller: "UserController"
				title:"UserList"
			)
		$routeProvider.otherwise({
			templateUrl: "public/404.html",
			controller: "PublicController"
			})
])