module Questions
  class DoorMaterialController < ApplicationController
    def index
      @form = DoorMaterialForm.new
    end

    def submit
      @form = DoorMaterialForm.new(door_material_form_params)

      unless @form.valid?
        return redirect_to(
          questions_door_material_path,
          alert: @form.errors.full_messages
        )
      end

      store_form_in_session!

      case @form.door_material
      when 'wood'
        render body: 'wood - Not currently implemented'
      else
        render body: 'Not currently implemented'
      end
    end

    private

    def door_material_form_params
      params.require(:door_material_form).permit!
    end

    def store_form_in_session!
      SelectedAnswerStore
        .new(session)
        .store_selected_answers(:door_material, @form.door_material)
    end
  end
end
