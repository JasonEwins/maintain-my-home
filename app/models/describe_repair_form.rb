class DescribeRepairForm
  include ActiveModel::Model

  attr_reader :repair_description

  validate :mandatory_fields_present

  def initialize(hash = {})
    @repair_description = hash[:repair_description]
  end

  private

  def mandatory_fields_present
    return if @repair_description.present?

    errors.add(:base, I18n.t('errors.no_selection'))
  end
end
