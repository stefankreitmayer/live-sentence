defmodule LiveSentence.RoomController do
  use LiveSentence.Web, :controller

  alias LiveSentence.Room

  def show(conn, _params) do
    room = Repo.get!(Room, 1)
    json conn, %{sentence: String.split(room.sentence, "|")}
  end

  def update(conn, %{"pos" => pos, "val" => val}) do
    room = Repo.get!(Room, 1)
    {pos, ""} = Integer.parse(pos)
    sentence = String.split(room.sentence, separator)
                |> List.replace_at(pos, val)
                |> Enum.join(separator)
    Room.changeset(room, %{sentence: sentence}) |> Repo.update!
    json conn, %{sentence: sentence}
  end

  defp separator do
    "|"
  end
end
