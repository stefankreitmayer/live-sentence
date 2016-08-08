defmodule LiveSentence.Roomkey do
  # numbers and lowercase letters
  # excluding similar looking characters and
  # excluding vowels to avoid english words
  # @alphabet String.split("bcdfghjkmnpqrstvwxyz23456789", "", trim: true)
  @alphabet String.split("bcdfghjkmnpqrstvwxyz23456789", "", trim: true)

  def random do
    Enum.map_join([0,0,0,0], "", &randomCharacter/1)
  end

  defp randomCharacter(_) do
    Enum.random(@alphabet)
  end
end
