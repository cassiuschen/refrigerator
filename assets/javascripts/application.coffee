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
	'$location',
	($rs, $lc) ->
		$rs.isLoading = true
		$rs.path = $lc.path()
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


window.base =
	toggleNav : ->
		$("#nav.ui.sidebar").first().sidebar 'attach events', '#navToggle', 'scale down'

	Init : ->
		window.base.toggleNav()

# Others ==================================================
$(document).ready ->
	window.base.Init()

window.onresize = ->
