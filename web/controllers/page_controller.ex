defmodule LiveSentence.PageController do
  use LiveSentence.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
