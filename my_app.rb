require 'sinatra'
require 'sass'
require 'coffee-script'
require 'slim'
require 'Digest'

class KitchenApp < Sinatra::Base
  #use Rack::Lint
  # Settings
  set :public_folder, File.dirname(__FILE__) + '/public'
  #set :port, '8080'
  set :bind, '0.0.0.0'
  set :logging, true
  set :sessions, true
  set :views, :scss => 'assets/stylesheets', :coffee => 'assets/javascripts', :slim => 'views', :default => 'views'

  # LeanCloud Info
  set :AVOSAppId, '4q5lj4x9fb41lpzl76ara0t4twp4ebjdokeptw6evd9iuhfu'
  set :AVOSMasterKey, '02k5pewyb19ddu83zx3hxag3w84vekzb39jcex3yoj7aw7kq'
  set :AVOSAppKey, 'xmieotk7xgofub983uedxr4osicyk1ag2jn5adm2f3593aua'
  helpers do
    def find_template(views, name, engine, &block)
      _, folder = views.detect { |k,v| engine == Tilt[k] }
      folder ||= views[:default]
      super(folder, name, engine, &block)
    end
  end


  # Assets
  get '/assets/application.js' do
    coffee :application
  end

  get '/assets/services.js' do
    coffee :services
  end

  get '/assets/controller.js' do
    coffee :controller
  end

  get '/assets/application.css' do
    scss :application, :style => :expanded
  end

  # Pages
  get '/' do
    slim :index
  end

  get '/angular/index.html' do
    slim :index, layout: false
  end

  # App
  run! if app_file == $0
end
