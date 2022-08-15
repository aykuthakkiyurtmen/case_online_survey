require "rails_helper"

RSpec.describe "Api::V1::Surveys", type: :request do
  let!(:survey) { create(:survey) }

  let!(:question) do
    create(:question, survey_id: survey.id, question_type: 1, title: "test question")
  end

  let!(:question_two) do
    create(:question, survey_id: survey.id, question_type: 0, title: "test question2")
  end

  let!(:option_one) { create(:option, question_id: question.id, title: "haftada bir") }
  let!(:option_two) { create(:option, question_id: question.id, title: "ayda bir") }

  before do
    question = Question.create!(title: "test", question_type: 1, survey_id: survey.id)
    Option.create!(title: "haftada bir", question_id: question.id)
    Option.create!(title: "ayda bir", question_id: question.id)
  end

  describe "POST #survey" do
    it "create response and feedback" do
      assert_difference("Feedback.count") do
        post_request("memnun kaldim", "test", "haftada bir")
      end

      expect(response).to have_http_status(:created)
      expect(Response.last.option_id).not_to be_nil
      expect(Response.count).to eq(1)

      expect(response.body).to eq("memnun kaldim")
    end

    it "create response and feedback without option" do
      body = "test"
      assert_difference("Feedback.count") do
        post_request(body, "test")
      end

      expect(response).to have_http_status(:created)
      expect(Response.last.option_id).to be_nil
      expect(Response.count).to eq(1)
    end

    it "when question is invalid to create it should return error" do
      assert_no_difference("Feedback.count") do
        post_request("memnun kaldim", "test1", "haftada bir")
      end

      expect(response).to have_http_status(:unprocessable_entity)
      expect(Response.count).to eq(0)

      expect(response.body).to eq("validation error: [\"Question must exist\"]")
    end

    it "when question is bot exist to create it should return error" do
      body = "test"
      assert_no_difference("Feedback.count") do
        post_request(body * 80, "test", "haftada bir")
      end

      expect(response).to have_http_status(:unprocessable_entity)
      expect(Response.count).to eq(0)

      expect(response.body).to eq("validation error: [\"Body is too long (maximum is 200 characters)\"]")
    end
  end

  describe "Post #survey bulk" do
    it "create response with option successfully" do
      assert_difference("Feedback.count") do
        bulk_post_request("", question.id, option_one.id)
      end

      expect(response).to have_http_status(:created)
      expect(Response.count).to eq(1)
    end

    it "create response with text successfully" do
      assert_difference("Feedback.count") do
        bulk_post_request("test", question_two.id)
      end

      expect(response).to have_http_status(:created)
      expect(Response.count).to eq(1)
    end
  end

  describe "Get #survey" do
    it "returns a list of survey" do
      survey_id = survey.id
      get "/api/v1/surveys/#{survey_id}"
      expect(response).to have_http_status(:ok)

      expect(parsed_response_body["data"]["attributes"]["name"]).to eq("test survey")
      expect(parsed_response_body["included"][0]["attributes"]["title"]).to eq("test question")
      expect(parsed_response_body["included"][0]["attributes"]["options"]).to eq(["haftada bir",
                                                                                  "ayda bir"])
    end
  end

  private

  def post_request(body, question, option = nil)
    post "/api/v1/surveys/#{survey.id}", params:
      {
        body: body,
        question: question,
        option: option
      }
  end

  def bulk_post_request(body, question, option = {})
    post "/api/v1/surveys/#{survey.id}", params:
      {
        posts_list: [
          {
            body: body,
            question: question,
            option: option
          }
        ]
      }
  end
end
