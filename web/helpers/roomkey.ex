defmodule LiveSentence.Roomkey do
  def generate(id) do
    String.pad_leading("#{id}", 4, "a")
  end
end
