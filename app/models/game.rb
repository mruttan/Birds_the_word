class Game

  def initialize(length = 10)
    @length = length
    @current_quesions = []
  end

  def generate_quotes
     Quote.order("RANDOM()").first(@length)
  end

  def generate_answers(question)
    answer1 = question.author
    #where Author.id is NOT question.answer.id
    wrong_answers = Author.where('id NOT IN (?)', question.author_id).order("RANDOM()").first(2)
    answers = []
    wrong_answers.each do |x|
      answers << x.name
    end
    answers << answer1.name
    answers
  end

end