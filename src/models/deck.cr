class Deck < BaseModel
  table do
    column title : String
    has_many questions : Question
  end
end
