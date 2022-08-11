survey = Survey.create!(name: "musteri memnuniyeti")
question = Question.create!(title: "bu urunu ne siklikla kullaniyorsunuz", question_type: 1,
                            survey_id: survey.id)
Option.create!(title: "haftada bir", question_id: question.id)
Option.create!(title: "ayda bir", question_id: question.id)
