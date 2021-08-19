class DeckSerializer < BaseSerializer
  def initialize(@deck : Deck, @with_questions : Bool = false)
  end

  def render
    data = { 
      id: @deck.id,
      title: @deck.title,
    }
    @with_questions ? data.merge(questions: QuestionSerializer.for_collection(@deck.questions)) : data
  end
end