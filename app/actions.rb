# Homepage (Root path)

enable :sessions
use Rack::Flash

helpers do

  def log_in?
    if session[:current_user]
      @user = User.find(session[:current_user])
    else 
      redirect '/sign_in'
    end
  end

  def get_user
    @user = User.find_by(id: params[:id])
    redirect '/leaderboard' unless @user
  end

  def get_question
    
    @game = Game.new

    if session[:played_questions] == []
      @question = Quote.order("RANDOM()").first
      session[:played_questions] << @question.id
      erb :index
    elsif session[:played_questions].count == Quote.count
      session[:played_questions] = []
      redirect '/game_over'
    else
      @questions = Quote.where('id NOT IN (?)', session[:played_questions])
      @question = @questions.shuffle.first

      if @question
        session[:played_questions] << @question.id
      else
        @user = User.find_by_id(session[:current_user])
        @question = "Great Game! Your final score was: #{@user.total_score}"
      erb :index
      end

      erb :index
    end

  end
  
end

get '/sign_in' do
  if session[:current_user]
    redirect '/'
  else
    erb :sign_in
  end
end

post '/sign_in' do
  @user = User.find_by username: params[:username] 
  if @user
    if @user.is_password?(params[:password])
      session[:current_user] = @user.id
      session[:played_questions] = []
      session[:session_score] = 0
      redirect '/'
    else
      flash[:notice] = "Incorrect password"
      redirect '/sign_in'
    end
  else
    flash[:notice] = "Username not found"
    redirect '/sign_in'
  end
end

post '/sign_up' do
  @user = User.new(
    name: params[:name],
    username: params[:username],
    password: params[:password]
  )
  if @user.save
    session[:current_user] = @user.id
    redirect '/'
  else
    erb :sign_in
  end
end

get '/' do
  log_in?
  get_question
end

get '/user/:id' do
  log_in?
  get_user
  erb :'user/show'
end


get '/correct' do
  log_in?
  @user.total_score += 1
  @user.scores.create(score: 1)
  @user.save
  session[:session_score] += 1
  redirect '/'
end

get '/wrong_answer' do
  log_in?
  @user.total_score -= 1
  @user.scores.create(score: -1)
  @user.save
  session[:session_score] -= 1
  redirect '/'
end

get '/leaderboard' do
  log_in?
  erb :leaderboard
end

get '/game_over' do
  log_in?
  erb :game_over
end 


get '/logout' do
  session[:current_user] = nil
  session[:played_questions] = []
  session[:session_score] = 0
  session = nil
  redirect '/'
end
