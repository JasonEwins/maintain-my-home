namespace :graph do
  task generate: :environment do
    questions = QuestionSet.new.questions

    File.open('./decision.dot', 'w') do |f|
      f.write "digraph decision {\n"

      questions.each do |id, question|
        f.write "  #{id} [label=\"#{question['question']}\"]\n"
      end

      questions.each do |id, question|
        answers = question['answers']
        if answers
          answers.each do |answer|
            if answer.key?('goto')
              f.write "  #{id} -> #{answer['goto']} [label=\"#{answer['text']}\"]\n"
            elsif answer.key?('page')
              f.write "  #{id} -> page_#{answer['page']} [label=\"#{answer['text']}\"]\n"
            else
              # f.write "  #{id} -> done [label=\"#{answer['text']}\"]\n"
            end
          end
        else
          if question.key?('goto')
            f.write "  #{id} -> #{question['goto']}\n"
          else
            # f.write "  #{id} -> done\n"
          end
        end

        f.write "\n"
      end

      f.write "}\n"
    end
  end
end
