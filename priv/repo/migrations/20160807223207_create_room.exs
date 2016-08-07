defmodule LiveSentence.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :sentence, :text

      timestamps()
    end

  end
end
