defmodule LiveSentence.Router do
  use LiveSentence.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LiveSentence do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/api", LiveSentence do
    pipe_through :api

    post "/join", RoomController, :join
    post "/create", RoomController, :create
    get "/poll", RoomController, :show
    post "/update", RoomController, :update
  end
end
