class QuestionSet
  class UnknownQuestion < StandardError; end

  QUESTION_STORE ||= YAML.parse(File.read(Rails.root + 'db/questions.yml')).to_ruby

  def self.find(node_name)
    raise UnknownQuestion unless QUESTION_STORE.key?(node_name)

    Question.new(node_name)
  end
end

class Question
  attr_reader :question
  attr_reader :answers

  def initialize(node_name)
    q = QuestionSet::QUESTION_STORE[node_name]

    @question = q['question']
    @answers_metadata = q['answers']
    @answers = @answers_metadata.collect { |answer| answer['text'] }
  end

  def next_question_by_answer(answer)
    selected_answer = @answers_metadata.select { |metadata| metadata['text'].eql?(answer) }
    selected_answer[0]['goto']
  end
end
