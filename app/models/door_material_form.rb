class DoorMaterialForm
  include ActiveModel::Model

  attr_reader :door_material

  validate :mandatory_fields_present

  def initialize(hash = {})
    @door_material = hash[:door_material]
  end

  private

  def mandatory_fields_present
    return if @door_material.present?

    errors.add(:base, I18n.t('errors.no_selection'))
  end
end
