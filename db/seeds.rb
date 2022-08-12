survey = Survey.create!(name: "musteri memnuniyeti")
question = Question.create!(title: "bu urunu ne siklikla kullaniyorsunuz", question_type: 1,
                            survey_id: survey.id)
Option.create!(title: "haftada bir", question_id: question.id)
Option.create!(title: "ayda bir", question_id: question.id)

question1 = Question.create!(title: "urun hakkinda onerileriniz?", question_type: 0,  survey_id: survey.id)

