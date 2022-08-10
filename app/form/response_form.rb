module ResponseForm
  class Form
    include ActiveModel::AttributeAssignment
    include ActiveModel::Validations

    attr_accessor :body, :question, :option

    def initialize(body, question, option)
      @body = body
      @question = question
      @option = option
    end

    def form_object
      find_question_id_by_title
      response = Response.new
      response.assign_attributes(question_id: @question_id, body:
        @body, option_id: @option&.id)
      response.valid? ? response : response.errors.full_messages
    end

    def survey_id
      @question.survey.id
    end

    private

    def find_question_id_by_title
      @question = Question.find_by(title: @question)
      set_question_id if @question.present?
      find_option_by_title
    end

    def find_option_by_title
      @option = Option.find_by(title: @option)
    end

    def set_question_id
      @question_id = @question.id
    end
  end
end