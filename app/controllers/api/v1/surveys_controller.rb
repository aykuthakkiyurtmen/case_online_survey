class Api::V1::SurveysController < ApplicationController
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  include ResponseForm
  include Errors

  def create
    feedback = build_response
    return if feedback.nil?

    Response.transaction do
      feedback.save!
      @response.feedback_id = feedback.id

      @response.save!
      render json: @response.body, status: :created
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

  def build_response
    object = ResponseForm::Form.new(params[:body], params[:question], params[:title])
    @response = object.form_object

    @error = Errors::error(@response)
     if @error[:status] == 'error'
       render json: @error[:message]
       return
     end

    build_feedback(object)
  end

  def build_feedback(object)
    feedback = Feedback.new
    feedback.survey_id = object.survey_id
    feedback
  end
end
