module ResponseForm
  class Test
    include ActiveModel::AttributeAssignment
    attr_accessor :body, :question, :option

    def initialize(body, question, option)
      @body = body
      @question = question
      @option = option
      find_question_id_by_title
      find_question_id_by_option
    end

    def form_object
      response = Response.new
      response.assign_attributes(question_id: @question_id, body:
        @body, option_id: @option_id)
      response
    end

    def survey_id
      @question.survey.id
    end

    private

    def find_question_id_by_title
      @question = Question.find_by(title: @question)
      @question_id = @question.id
    end

    def find_question_id_by_option
      @option_id = Option.find_by(title: @option).id
    end
  end
end