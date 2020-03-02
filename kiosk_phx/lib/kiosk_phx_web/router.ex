defmodule KioskPhxWeb.Router do
  use KioskPhxWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", KioskPhxWeb do
    pipe_through :browser

    get "/", PageController, :index
    live "/rainbow", RainbowLive
    live "/brightness", BrightnessLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", KioskPhxWeb do
  #   pipe_through :api
  # end
end
