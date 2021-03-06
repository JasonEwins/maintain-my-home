class Confirmation
  class InvalidCallbackTimeError < StandardError; end

  attr_reader :repair_request_id

  def initialize(repair_request_id:, answers:)
    @repair_request_id = repair_request_id
    @answers = answers
  end

  def address
    address_answer = @answers.fetch('address')
    [
      address_answer.fetch('short_address'),
      address_answer.fetch('postcode'),
    ].join(', ')
  end

  def full_name
    contact_details_answer.fetch('full_name')
  end

  def telephone_number
    number = contact_details_answer.fetch('telephone_number')
    format_telephone_number(number)
  end

  def callback_time
    case contact_details_answer.fetch('callback_time')
    when ['morning']
      'between 8am and 12pm'
    when ['afternoon']
      'between 12pm and 5pm'
    when %w[morning afternoon]
      'between 8am and 5pm'
    else
      raise InvalidCallbackTimeError
    end
  end

  def description
    @answers.fetch('describe_repair').fetch('description')
  end

  private

  def contact_details_answer
    @answers.fetch('contact_details')
  end

  def format_telephone_number(number)
    number.delete("\s")
  end
end
