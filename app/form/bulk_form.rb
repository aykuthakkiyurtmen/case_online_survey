module BulkForm
  class FORM
    include ActiveModel::Validations

    def self.build_bulk_response(post_params, feedback, survey)
      Response.transaction do
        feedback.save!

        response = Response.new
        response.feedback_id = feedback.id
        question = survey.questions.find(post_params["question"])
        response.question = question
        response.option = question.options.find(post_params["option"]) unless post_params["option"].nil?
        response.body = post_params["body"] if (question.question_type == "text")

        if response.body.nil? and response.option.nil? || !response.valid?
          return @errors
        end
        response.save!
      end
    end
  end
end
