module Questions
  class DescribeRepairController < ApplicationController
    def index
      @form = DescribeRepairForm.new
    end

    def submit
      @form = DescribeRepairForm.new(describe_repair_form_params)

      unless @form.valid?
        return redirect_to(
          questions_describe_repair_path,
          alert: @form.errors.full_messages
        )
      end

      store_form_in_session!

      render body: 'Not currently implemented'
    end

    private

    def describe_repair_form_params
      params.require(:describe_repair_form).permit!
    end

    def store_form_in_session!
      SelectedAnswerStore
        .new(session)
        .store_selected_answers(:repair_description, @form.repair_description)
    end
  end
end
