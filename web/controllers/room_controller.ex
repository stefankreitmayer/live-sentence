defmodule LiveSentence.RoomController do
  use LiveSentence.Web, :controller

  alias LiveSentence.Room
  alias LiveSentence.Roomkey

  def create(conn, _) do
    room = try_create_room(10)
    render_admission conn, room.roomkey
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

  defp dummy_sentence do
    "our dog|often|chases|butterflies"
  end

  defp try_create_room(attempts) do
    IO.puts("attempts #{attempts}")
    if attempts<1 do
      nil
    else
      new_room || try_create_room(attempts-1)
    end
  end

  defp new_room do
    changeset = Room.changeset(%Room{}, %{sentence: dummy_sentence, roomkey: Roomkey.random})
    case Repo.insert(changeset) do
      {:ok, room} ->
        room
      {:error, _} ->
        nil
    end
  end
end
