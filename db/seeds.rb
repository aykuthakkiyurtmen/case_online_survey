survey = Survey.create!(name: "musteri memnuniyeti")
question = Question.create!(title: "memnunmusunuz",question_type: 1, survey_id: survey.id)
Option.create!(title: "neden", question_id: a.id)
