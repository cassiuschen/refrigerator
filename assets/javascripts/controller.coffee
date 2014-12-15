window.Kitchen
  .controller 'IndexController', [
    '$scope',
    'Dishes',
    'Dish',
    'Steps',
    '$rootScope',
    'Images',
    '$location',
    ($scope, Dishes, Dish, Steps, $rootScope, Images, $location) ->
      # Data
      $scope.onClickId = "" # Initialize onClick Event
      $scope.dishes = Dishes.query {}, () ->
        $rootScope.isLoading = false

      $rootScope.path = $location.path()
      $scope.detailLoaded = false
      $scope.steps = Steps.all()

      $scope.createDish = () ->
        Dishes.create {
          title: $("input#title").val()
          des: $("input#des").val()
        }, () ->
          $("input#title").val("")
          $("input#des").val("")
          $scope.dishes = Dishes.query()

      # Actions
      $scope.changeData = (index) ->
        $rootScope.isLoading = true
        $scope.detailLoaded = false
        $scope.onClickId = index
        $scope.DishInfo = Dish.info { DishId: index }
        $scope.DishThumb = Images.query {
          where:
            $relatedTo:
              object:
                __type: "Pointer"
                className: "Dish"
                objectId: index
              key: "thumb"
          }
        $scope.DishSteps = Steps.query {
          where:
            $relatedTo:
              object:
                __type: "Pointer"
                className: "Dish"
                objectId: index
              key: "step"
        }, () ->
          $rootScope.isLoading = false
          $scope.detailLoaded = true
  ]