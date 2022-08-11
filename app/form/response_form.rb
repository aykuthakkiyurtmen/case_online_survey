module ResponseForm
  class Form
    include ActiveModel::AttributeAssignment
    include ActiveModel::Validations

    attr_accessor :body, :question_title, :option_title, :survey_id

    def initialize(body, question_title, option_title, survey_id)
      @body = body
      @question_title = question_title
      @option_title = option_title
      @survey_id = survey_id
    end

    def form_object
      find_question_id_by_title

      response = Response.new
      response.assign_attributes(question_id: @question_id, body:
        body, option_id: @option&.id)

      response.valid? ? response : response.errors.full_messages
    end

    def set_survey_id
      survey_id
    end

    private

      def find_question_id_by_title
        survey = Survey.find(survey_id)
        @question = survey.questions.find_by(title: question_title)

        set_question_id if @question.present?
        find_option_by_title if @question.present?
      end

      def find_option_by_title
        @option = @question.options.find_by(title: option_title)
      end

      def set_question_id
        @question_id = @question.id
      end
  end
end
