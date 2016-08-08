defmodule LiveSentence.Room do
  use LiveSentence.Web, :model

  schema "rooms" do
    field :sentence, :string
    field :roomkey, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:sentence, :roomkey])
    |> validate_required([:sentence])
    |> unique_constraint(:roomkey)
  end
end
