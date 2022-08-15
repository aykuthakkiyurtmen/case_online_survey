class Api::V1::SurveysController < ApplicationController
  before_action :find_survey, only: %i[create]

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
    options = { include: [:questions] }

    render json: SurveySerializer.new(survey, options)
  end

  private

  def build_response
    object = ResponseForm::Form.new(params[:body], params[:question], params[:option],
                                    params[:id])
    @response = object.form_object
    @error = Errors.error(@response)

    if @error[:status] == 'error'
      render json: @error[:message], status: :unprocessable_entity
      return
    end

    build_feedback
  end

  def build_bulk_response
    feedback = Feedback.new(survey: @survey)

    BulkForm::FORM.build_bulk_response(params[:posts_list], feedback, @survey)
    render json: 'responses are added', status: :created
  end

  def find_survey
    @survey = Survey.find(params[:id])
  end

  def build_feedback
    feedback = Feedback.new
    feedback.survey_id = @survey.id

    feedback
  end
end
