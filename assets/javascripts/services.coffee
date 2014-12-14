window.KitchenServices = angular.module 'KitchenServices', [
  "ngResource"
]

window.KitchenServices
  .factory 'Dish', [
    "$resource"
    ($resource) ->
      $resource "#{window.BASE_URL}/classes/Dish/:DishId", {},
        info:
          method: 'GET'
          params:
            DishId: 'ID'
          isArray: false
        update:
          method: 'PUT'
          isArray: false
        delete:
          method: 'DELETE'
          isArray: false
  ]
  .factory 'Dishes', [
    "$resource"
    ($resource) ->
      $resource "#{window.BASE_URL}/classes/Dish", {},
        query:
          method: 'GET'
        create:
          method: 'POST'
  ]
  .factory 'Steps', [
    "$resource"
    ($resource) ->
      $resource "#{window.BASE_URL}/classes/Step", {},
        query:
          method: 'GET'
          params:
            where:
              $relatedTo:
                object:
                  __type: "Pointer"
                  className: "Dish"
                  objectId: ""
                key: "steps"
        all:
          method: "GET"
  ]