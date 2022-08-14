class Api::V1::SurveysController < ApplicationController
  protect_from_forgery with: :null_session
  include Errors

  def create
    return build_bulk_response if params[:posts_list].present?

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
    object = ResponseForm::Form.new(params[:body], params[:question], params[:option], params[:id])
    @response = object.form_object

    @error = Errors.error(@response)

    if @error[:status] == "error"
      render json: @error[:message], status: :unprocessable_entity
      return
    end

    build_feedback(object)
  end

  def build_bulk_response
    find_survey

    feedback = Feedback.new(survey: @survey)
    params[:posts_list].each do |post_params|
      BulkForm::FORM.build_bulk_response(post_params, feedback, @survey)
    end

    render json: "feedbacks are added", status: :created
  end

  def find_survey
    @survey = Survey.find(params[:id])
  end

  def build_feedback(object)
    feedback = Feedback.new
    feedback.survey_id = object.set_survey_id

    feedback
  end
end
