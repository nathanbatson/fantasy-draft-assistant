var draftApp = angular.module('draftApp', ['ngAnimate'])

draftApp.controller('playersController', function($scope, $http){
  $scope.players = [];
  $scope.positions = ["QB", "RB", "WR", "TE", "K", "DST"];
  $scope.selected_positions = ["RB", "WR", "TE"];
  $scope.drafted_players = [];
  $scope.search = "";

  $scope.toggleSelection = function toggleSelection(positionName) {
    var idx = $scope.selected_positions.indexOf(positionName);

    if (idx > -1) {
      $scope.selected_positions.splice(idx, 1);
    } else {
      $scope.selected_positions.push(positionName);
    }
  };

  $scope.myTeamFilter = function(player){
    return player.drafted_by == 'me';
  }

  $scope.positionFilter = function(player){
    return $scope.selected_positions.indexOf(player.position_name) != -1;
  }

  $scope.draftedFilter = function(player){
    return player.drafted_by != "me" || player.drafted_by != "other";
  }

  $scope.draftPlayer = function(player, drafted_by) {
    player.drafted_by = drafted_by;
    $scope.drafted_players.push(player);

    var idx = $scope.players.indexOf(player);
    if (idx > -1) {
      $scope.players.splice(idx, 1);
    }

    $http.post('/players/update', {id: player.id, drafted_by:drafted_by}).success(function(data) {
      // placeholder for manipulation
    });
  }

  // get players
  $http.get('/players/index.json').
    success(function(data) {
      $scope.players = data.players;
      $scope.drafted_players = data.drafted_players;
      // console.log(data.players);
    });
})