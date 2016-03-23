# Homepage (Root path)

get '/' do
  @game = Game.new
  @questions = @game.generate_quotes
  erb :index
end

get '/correct' do
 # current_user.total_score + 1
 redirect '/'
end

get '/incorrect' do
 # current_user.total_score - 1
 redirect '/'
end
