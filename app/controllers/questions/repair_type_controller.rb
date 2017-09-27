module Questions
  class RepairTypeController < ApplicationController
    def index
      @form = RepairTypeForm.new
    end

    def submit
      @form = RepairTypeForm.new(repair_type_form_params)

      unless @form.valid?
        return redirect_to(
          questions_repair_type_path,
          alert: @form.errors.full_messages
        )
      end

      store_form_in_session!

      case @form.repair_type
      when 'damaged_door'
        redirect_to questions_door_material_path
      else
        render body: 'Not currently implemented'
      end
    end

    private

    def repair_type_form_params
      params.require(:repair_type_form).permit!
    end

    def store_form_in_session!
      SelectedAnswerStore
        .new(session)
        .store_selected_answers(:repair_type, @form.repair_type)
    end
  end
end
