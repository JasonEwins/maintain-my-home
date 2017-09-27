class DoorLocationForm
  include ActiveModel::Model

  attr_reader :door_location

  validate :mandatory_fields_present

  def initialize(hash = {})
    @door_location = hash[:door_location]
  end

  private

  def mandatory_fields_present
    return if @door_location.present?

    errors.add(:base, I18n.t('errors.no_selection'))
  end
end
