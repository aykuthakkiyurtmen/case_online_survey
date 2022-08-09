class Api::V1::SurveysController < ApplicationController

  def show
    survey = Survey.find(params[:id])
    options = {
      include: [:questions]
    }
    render json: SurveySerializer.new(survey, options)
  end
end
