require 'rails_helper'

RSpec.describe Questions::StartController do
  describe '#submit' do
    it 'stores valid responses to the session' do
      post :submit, params: { start_form: { priority_repair: 'Yes' } }

      answers = SelectedAnswerStore.new(session).selected_answers

      expect(answers).to include(priority_repair: 'Yes')
    end
  end
end
