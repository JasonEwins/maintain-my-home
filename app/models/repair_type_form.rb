class RepairTypeForm
  include ActiveModel::Model

  attr_reader :repair_type

  validate :mandatory_fields_present

  def initialize(hash = {})
    @repair_type = hash[:repair_type]
  end

  private

  def mandatory_fields_present
    return if @repair_type.present?

    errors.add(:base, I18n.t('errors.no_selection'))
  end
end
