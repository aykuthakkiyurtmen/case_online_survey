class Api::V1::SurveysController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  include ResponseForm

  def create
    feedback = built_response_and_feedback

    Response.transaction do
      feedback.save!

      @response.feedback_id = feedback.id
      @response.save!
    end
  end

  def show
    survey = Survey.find(params[:id])
    options = {
      include: [:questions]
    }
    render json: SurveySerializer.new(survey, options)
  end


  private

  def built_response_and_feedback
    object = ResponseForm::Test.new(params[:body], params[:question], params[:option])
    @response = object.form_object
    feedback = Feedback.new

    feedback.survey_id =object.survey_id
    feedback
  end
end
