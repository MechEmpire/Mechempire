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
				controller: "UserListController"
				title:"机甲帝国-用户列表"
			).when('/users/:userid',
				templateUrl: "user/user_info.html"
				controller: "UserController"
			).when('/404',
				templateUrl: "public/404.html"
			)
		$routeProvider.otherwise({
			templateUrl: "public/404.html"
			})
])