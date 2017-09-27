module Questions
  class BathWaterRisingController < ApplicationController
    def index
      @form = BathWaterRisingForm.new
    end

    def submit
      @form = BathWaterRisingForm.new(bath_water_rising_form_params)

      unless @form.valid?
        return redirect_to(
          questions_bath_water_rising_path,
          alert: @form.errors.full_messages
        )
      end

      store_form_in_session!

      redirect_to new_address_search_path
    end

    private

    def bath_water_rising_form_params
      params.require(:bath_water_rising_form).permit!
    end

    def store_form_in_session!
      SelectedAnswerStore
        .new(session)
        .store_selected_answers(:bath_water_rising, @form.bath_water_rising)
    end
  end
end
