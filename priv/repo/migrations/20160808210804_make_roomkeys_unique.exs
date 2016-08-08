defmodule LiveSentence.Repo.Migrations.MakeRoomkeysUnique do
  use Ecto.Migration

  def change do
    create unique_index(:rooms, [:roomkey])
  end
end
