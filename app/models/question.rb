class Question
  class InvalidAnswerError < StandardError; end

  attr_reader :title
  attr_reader :next_question

  def initialize(question_hash)
    @title = question_hash['question']
    @answers = question_hash['answers'] || []
    @next_question = question_hash['next']
  end

  def answers_for_collection
    @answers.map { |answer| answer['text'] }
  end

  def answer_data(chosen_answer)
    @answers.detect { |answer| answer['text'] == chosen_answer }.tap do |data|
      raise InvalidAnswerError if data.nil?
    end
  end

  def redirect_path_for_answer(chosen_answer)
    answer_hash = answer_data(chosen_answer)

    if answer_hash.key?('next')
      Rails.application.routes.url_helpers.questions_path(answer_hash['next'])
    elsif answer_hash.key?('page')
      Rails.application.routes.url_helpers.page_path(answer_hash['page'])
    else
      Rails.application.routes.url_helpers.describe_repair_path
    end
  end

  def redirect_path
    if next_question.nil?
      return Rails.application.routes.url_helpers.address_search_path
    end

    Rails.application.routes.url_helpers.questions_path(next_question)
  end

  def multiple_choice?
    @answers.any?
  end
end
