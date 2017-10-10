class Question
  attr_reader :title
  attr_reader :answers

  def initialize(question_hash)
    @title = question_hash['question']
    @answers = question_hash['answers']
  end

  def answers_for_collection
    answers.map { |answer| answer['text'] }
  end

  def redirect_path_for_answer(chosen_answer)
    answer_hash = answers.detect { |answer| answer['text'] == chosen_answer }

    if answer_hash.key?('goto')
      Rails.application.routes.url_helpers.questions_path(answer_hash['goto'])
    else
      Rails.application.routes.url_helpers.address_search_path
    end
  end
end

