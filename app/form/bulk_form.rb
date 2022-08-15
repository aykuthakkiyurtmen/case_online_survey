module BulkForm
  class FORM
    include ActiveModel::Validations

    def self.build_bulk_response(post_list, feedback, survey)
      Response.transaction do
        feedback.save!
        post_list.each do |post_params|
          response = Response.new
          response.feedback_id = feedback.id
          question = survey.questions.find(post_params['question'])
          response.question = question

          unless post_params['option'].nil?
            response.option = question.options.find(post_params['option'])
          end

          response.body = post_params['body'] if question.question_type == 'text'

           if response.body.nil? and response.option.nil? || !response.valid?
             # this business can be used to handle errors for missing responses.

             # ex: Error feedbacks that cannot be added, can be responded with error messages.
             # response.errors ||= "xxxxx"
             # @errors << { errors: response.errors, status: :unprocessable_entity, answer: }
             return
           end
          response.save!
        end
      end
    end
  end
end
