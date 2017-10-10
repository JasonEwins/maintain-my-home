class Question
  attr_reader :title
  attr_reader :answers
  attr_reader :goto

  def initialize(question_hash)
    @title = question_hash['question']
    @answers = question_hash['answers'] || []
    @goto = question_hash['goto']
  end

  def answers_for_collection
    answers.map { |answer| answer['text'] }
  end

  def redirect_path_for_answer(chosen_answer)
    answer_hash = answers.detect { |answer| answer['text'] == chosen_answer }

    if answer_hash.key?('goto')
      Rails.application.routes.url_helpers.questions_path(answer_hash['goto'])
    elsif answer_hash.key?('page')
      Rails.application.routes.url_helpers.page_path(answer_hash['page'])
    else
      Rails.application.routes.url_helpers.describe_repair_path
    end
  end

  def redirect_path
    return Rails.application.routes.url_helpers.address_search_path if goto.nil?
    Rails.application.routes.url_helpers.questions_path(goto)
  end

  def multiple_choice?
    answers.any?
  end
end

