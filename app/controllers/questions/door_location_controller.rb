module Questions
  class DoorLocationController < ApplicationController
    def index
      @form = DoorLocationForm.new
    end

    def submit
      @form = DoorLocationForm.new(door_location_form_params)

      unless @form.valid?
        return redirect_to(
          questions_door_location_path,
          alert: @form.errors.full_messages
        )
      end

      store_form_in_session!

      case @form.door_location
      when 'communal'
        render body: 'Not currently implemented'
      else
        redirect_to new_address_search_path
      end
    end

    private

    def door_location_form_params
      params.require(:door_location_form).permit!
    end

    def store_form_in_session!
      SelectedAnswerStore
        .new(session)
        .store_selected_answers(:door_location, @form.door_location)
    end
  end
end
