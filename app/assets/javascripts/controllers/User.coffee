controllers = angular.module('controllers',[])

# User controllers
controllers.controller("UserController",['$rootScope','$routeParams', '$http','$route','$location'
	($rootScope, $routeParams, $http, $route, $location)->
		$rootScope.user = 
		{name:'', email:''}
		$rootScope.title = "机甲帝国-" + $rootScope.user.name

		loadUserInfo = ->
			$http.get('users/' + $routeParams.userid+'.json')
			.success((data) -> 
				$rootScope.user = data
				$rootScope.title = "机甲帝国-" + data.name
				console.log("Success")
			)
			.error(->
				$location.path("/404");
				console.log("Error")
			)
		loadUserInfo()
])
controllers.controller("UserListController", ['$rootScope','$http','$route'
	($rootScope, $http, $route) ->
		$rootScope.data =
		users: [{name:'', email:''}]
		$rootScope.title = $route.current.title
		
		loadUsers = ->
			$http.get('./users.json').success((data) -> 
					$rootScope.data.users = data
					console.log("Success")
				).error(->
					console.error("Fialed")
				)
		loadUsers()
])

# Public controllers
controllers.controller("NotFoundController",['$rootScope','$route'
	($rootScope, $route) -> 
		$rootScope.title = $route.current.title
])

# Index Controllers

controllers.controller("IndexController",['$rootScope','$route'
	($rootScope, $route) ->
		$rootScope.title = $route.current.title
])