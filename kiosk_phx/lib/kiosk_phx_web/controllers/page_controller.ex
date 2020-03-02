defmodule KioskPhxWeb.PageController do
  use KioskPhxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
