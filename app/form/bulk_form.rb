module BulkForm
  class FORM
    include ActiveModel::Validations

    def self.build_bulk_response(post_params, id)
      @a = 5
      Response.transaction do
        feedback = Feedback.new
        feedback.survey_id = id
        feedback.save!

        response = Response.new
        response.feedback_id = feedback.id
        question = Question.find (post_params["question"])
        response.question_id = post_params["question"]
        response.option_id = question.options.find(post_params["option"])["id"] unless post_params["option"].nil?
        response.body = post_params["body"] if (question.question_type == "text")

        if response.body.nil? and response.option_id.nil? || !response.valid?
            return
          end
        response.save!
      end
    end
  end
end
