window.Kitchen = angular.module 'KitchenApp', [
	'ngResource',
	'ngRoute',
	'ngSanitize',
	'ngCookies',
	"KitchenServices"
]

window.Kitchen.config(["$httpProvider", (provider) ->
	provider.defaults.headers.common['X-AVOSCloud-Application-Id'] = $('meta[name=X-AVOSCloud-Application-Id]').attr('content')
	# LeanCloud Application ID
	provider.defaults.headers.common['X-AVOSCloud-Application-Key'] = $('meta[name=X-AVOSCloud-Application-Key]').attr('content')
	#provider.defaults.headers.common['Content-Type'] = "application/json"
])

window.Kitchen.run [
	'$rootScope',
	($rs) ->
		$rs.isLoading = true
]

# Route
window.LOCAL_URL = "http://localhost:4567"
window.Kitchen.config [
	'$routeProvider',
	($routeProvider) ->
		$routeProvider
			.when '/',
				templateUrl: "#{window.LOCAL_URL}/angular/index.html"
				controller: "IndexController"

			.otherwise
				redirectTo: '/'
]

window.BASE_URL = "https://leancloud.cn/1.1"


# Others ==================================================
$(document).ready ->


window.onresize = ->
