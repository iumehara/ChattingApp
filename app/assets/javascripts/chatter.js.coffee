app = angular.module("Chatter", ["ngResource", 'ng-rails-csrf'])

@CommentCtrl = ($scope, $resource) ->
	Comment = $resource("/comments/:id", {id: "@id"}, {update: {method: "PUT"}})
	$scope.comments = Comment.query()

	# $scope.addComment = ->
	# 	$scope.comments.push($scope.newComment)
	# 	$scope.newComment = {}

	$scope.addComment = ->
		comment = Comment.save($scope.newComment)

		$scope.comments.push(comment)

		$scope.newComment = {}

@Chatter.config ["$httpProvider", ($httpProvider) ->
  token = $('meta[name=csrf-token]').attr('content')
  $httpProvider.defaults.headers.common['X-CSRF-Token'] = token
]