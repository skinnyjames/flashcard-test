class Home::Index < BrowserAction
  get "/" do
    html Flashcard::HomePage
  end
end
