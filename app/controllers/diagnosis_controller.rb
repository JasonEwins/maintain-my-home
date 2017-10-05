class DiagnosisController < ApplicationController
  def show
    @question = QuestionSet.find(params[:step])
  end

  def submit
    @question = QuestionSet.find(params[:step])

    chosen_answer = diagnosis_params['answer']

    redirect_to diagnosis_path(@question.next_question_by_answer(chosen_answer))
  end

  private

  def diagnosis_params
    params.require(:diagnosis).permit!
  end
end
