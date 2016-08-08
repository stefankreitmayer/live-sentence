defmodule LiveSentence.RoomController do
  use LiveSentence.Web, :controller

  alias LiveSentence.Room
  alias LiveSentence.Roomkey

  def create(conn, _) do
    room = Room.changeset(%Room{}, %{sentence: defaultSentence})
            |> Repo.insert!
    roomkey = Roomkey.generate(room.id)
    Room.changeset(room, %{roomkey: roomkey}) |> Repo.update!
    render_admission conn, roomkey
  end

  def join(conn, %{"roomkey" => roomkey}) do
    room = Repo.get_by(Room, roomkey: roomkey)
    unless room do
      render_rejection(conn)
    else
      render_admission conn, roomkey
    end
  end

  def show(conn, %{"roomkey" => roomkey}) do
    room = Repo.get_by!(Room, roomkey: roomkey)
    json conn, %{sentence: String.split(room.sentence, "|")}
  end

  def update(conn, %{"roomkey" => roomkey, "pos" => pos, "val" => val}) do
    room = Repo.get_by!(Room, roomkey: roomkey)
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

  defp render_admission(conn, roomkey) do
    json conn, %{accepted: roomkey}
  end

  defp render_rejection(conn) do
    json conn, %{}
  end

  defp defaultSentence do
    "our dog|chases|butterflies|in the garden"
  end
end
