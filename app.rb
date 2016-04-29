
require 'sinatra/base'
require './lib/player.rb'
require './lib/game.rb'

class Rps < Sinatra::Base
  enable :sessions

  get '/' do
      erb :index
    end

  post '/names' do
    player_1 = Player.new(params[:player_1_name])
    Game.create(player_1)
    redirect '/play'
  end

  before {@game = Game.game_in_play}

  get '/play' do
    erb :play
  end

  post '/result' do
    @result_1 = params[:type]
    @result_2 = @game.computer_draw
    @game.check_winner
  end

  # get '/game-over' do
  #   erb :game_over
  # end
  # start the server if ruby files executed directly
  run! if app_file == $0
end
