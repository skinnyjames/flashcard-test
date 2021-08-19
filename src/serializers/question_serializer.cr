class QuestionSerializer < BaseSerializer
  def initialize(@question : Question)
  end
  
  def render
    { 
      text: @question.text,
      answer: @question.answer,
      image: @question.image_url
    }
  end
end