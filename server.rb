require 'sinatra'
require 'rest-client'
require 'sinatra/reloader'

set :bind, '0.0.0.0'

helpers do
  def get(url)
    response = RestClient.get(url)
    JSON.parse(response)
  end
end

get '/' do
  erb :index
end

get '/movies' do

  @movies = get("movies.api.mks.io/movies")

  erb :"movies/index"
end

get '/actors' do

  @actors = get("movies.api.mks.io/actors")

  erb :"actors/index"
end

get '/movies/:id' do
  @movie_id = params[:id]
  @actors_by_movie = get("movies.api.mks.io/movies/#{@movie_id}/actors")
  @movies = get("movies.api.mks.io/movies")

  erb :"movies/movie"
end

get '/actors/:id' do
  @actor_id = params[:id]
  @movies_by_actor = get("movies.api.mks.io/actors/#{@actor_id}/movies")
  @actors = get("movies.api.mks.io/actors")

  erb :"actors/actor"
end