class BathWaterRisingForm
  include ActiveModel::Model

  attr_reader :bath_water_rising

  validate :mandatory_fields_present

  def initialize(hash = {})
    @bath_water_rising = hash[:bath_water_rising]
  end

  private

  def mandatory_fields_present
    return if @bath_water_rising.present?

    errors.add(:base, I18n.t('errors.no_selection'))
  end
end
