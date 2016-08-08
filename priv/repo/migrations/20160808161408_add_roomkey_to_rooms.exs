defmodule LiveSentence.Repo.Migrations.AddRoomkeyToRooms do
  use Ecto.Migration

  def change do
    alter table(:rooms) do
      add :roomkey, :string
    end
  end
end
