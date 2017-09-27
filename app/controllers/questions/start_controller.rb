module Questions
  class StartController < ApplicationController
    def index
      @form = StartForm.new
    end

    def submit
      @form = StartForm.new(start_form_params)

      unless @form.valid?
        return redirect_to(
          questions_start_path,
          alert: @form.errors.full_messages
        )
      end

      store_form_in_session!

      return redirect_to emergency_contact_path if @form.priority_repair?
      redirect_to questions_repair_type_path
    end

    private

    def start_form_params
      params.require(:start_form).permit!
    end

    def store_form_in_session!
      SelectedAnswerStore
        .new(session)
        .store_selected_answers(:priority_repair, @form.priority_repair)
    end
  end
end
