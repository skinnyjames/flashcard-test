class CreateQuestions::V20210818224632 < Avram::Migrator::Migration::V1
  def migrate
    # Learn about migrations at: https://luckyframework.org/guides/database/migrations
    create table_for(Question) do
      primary_key id : Int64
      add_timestamps
      add text : String
      add answer : String
      add image : String?
      add_belongs_to deck : Deck, on_delete: :cascade
    end
  end

  def rollback
    drop table_for(Question)
  end
end
