survey = Survey.create!(name: "musteri memnuniyeti")
question = Question.create!(title: "memnunmusunuz", survey_id: survey.id)
Type.create!(title: "memnunmusunuz", survey_id: survey.id)
