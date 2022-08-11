module Errors
  def self.error(response)
    return validation_errors(response) if response.is_a?(Array)
    return exist_question_error if response.question_id.nil?

    { status: 'valid' }
  end

  def self.validation_errors(response)
    { status: 'error', code: 3000, message: "validation error: #{response}" }
  end

  def self.exist_question_error
    { status: 'error', code: 3001, message: 'missing or wrong question title' }
  end
end
