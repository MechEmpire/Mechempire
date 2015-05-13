#= require_tree ./templates
#= require_tree ./controllers
#= require_self

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
				title: "机甲帝国 - 首页"
			).when('/users',
				templateUrl: "user/user_list.html"
				controller: "UserListController"
				title:"机甲帝国 - 用户列表"
			).when('/users/:userid',
				templateUrl: "user/user_info.html"
				controller: "UserController"
			)
		$routeProvider.otherwise({
			templateUrl: "public/404.html"
			controller: "NotFoundController"
			title: "404-NotFound"
		})
])