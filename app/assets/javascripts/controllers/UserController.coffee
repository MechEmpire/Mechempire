angular.module('controllers',[])
	.controller("UserController", ['$scope','$routeParams','$location','$http','$route'
		($scope, $routeParams,$location,$http,$route)->
			$scope.data =
			users: [{name:'last_tairy', email:'tairyguo@gmail.com'}]
			$scope.title = $route.current.title
			
			# loadUsers = ->
			# 	$http.get('./users.json').success((data) -> 
			# 			$scope.data.users = data
			# 			console.log("Success")
			# 		).error(->
			# 			console.error("Fialed")
			# 		)

			# loadUsers()
	])