
module Actions::Deck 

  class All < ApiAction
    get "/decks" do 
      decks = DeckQuery.new
      json(DeckSerializer.for_collection(decks))
    end
  end

  class One < ApiAction
    get "/decks/:id" do 
      deck = DeckQuery.new.join_questions.find(id)
      json(DeckSerializer.new(deck, true))
    end
  end

  class New < ApiAction
    # new deck
    post "/decks" do 
      deck = SaveDeck.create!(title: "My New Deck")
      json(DeckSerializer.new(deck))
    end
  end

  class NewQuestion < ApiAction
    # new question
    post "/decks/:id/questions" do 
      raise "Invalid Deck Id" unless deck = DeckQuery.new.find(id)
      question = SaveQuestion.create!(text: "Question", answer: "Answer", deck_id: deck.id)
      json QuestionSerializer.new(question)
    end
  end

  class  EditDeck < ApiAction
    put "/decks/:id" do 
      raise "Invalid Deck Id" unless deck = DeckQuery.new.find(id)
      puts params.to_h
      SaveDeck.update!(deck, title: params.from_json["title"].as_s)
      json(true)
    end
  end

  class EditQuestion < ApiAction
    put "/decks/:id/questions/:question_id" do 
      raise "Invalid Question Id" unless question = QuestionQuery.new.find(question_id)
      SaveQuestion.update!(question, text: params.from_json["text"].as_s, answer: params.from_json["answer"].as_s)
      json(true)
    end
  end

  class DeleteDeckAction < ApiAction
    delete "/decks/:id" do 
      raise "Invalid Deck Id" unless deck = DeckQuery.new.find(id)
      DeleteDeck.delete(deck) do |operation, deleted_deck|
        if operation.deleted? 
          json(true)
        else 
          raise "Delete failed"
        end
      end
    end
  end

  class DeleteQuestionAction < ApiAction
    delete "/decks/:id/questions/:question_id" do
      raise "Invalid Question Id" unless q = QuestionQuery.new.find(question_id)
      DeleteQuestion.delete(q) do |operation, deleted_question|
        if operation.deleted? 
          json(true)
        else 
          raise "Delete failed"
        end
      end
    end
  end
end
