class QuestionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :options

  attributes :options do |object|
    object.options.map { |obj| obj.title }
      end
end
