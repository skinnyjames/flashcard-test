class Question < BaseModel
  table do
    column text : String
    column answer : String
    column image : String
    belongs_to deck : Deck
  end
  
  def image_url(store="store")
    Shrine.find_storage(store).url(image)
  end
end