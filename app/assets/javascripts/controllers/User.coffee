controllers = angular.module('controllers',[])

controllers.controller("UserController",['$rootScope','$routeParams', '$http','$route','$location'
	($rootScope, $routeParams, $http, $route, $location)->
		$rootScope.user = 
		{name:'Tairy', email:'tairguo@gmail.com'}
		$rootScope.title = "机甲帝国-" + $rootScope.user.name

		loadUserInfo = ->
			$http.get('users/' + $routeParams.userid+'.json')
			.success((data) -> 
				$rootScope.user = data
				console.log("Success")
			)
			.error(->
				$location.path("/404");
				console.log("Error")
			)
		loadUserInfo()
])
controllers.controller("UserListController", ['$rootScope','$http','$route'
	($rootScope, $http, $route)->
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