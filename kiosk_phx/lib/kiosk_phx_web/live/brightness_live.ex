defmodule KioskPhxWeb.BrightnessLive do
  use Phoenix.LiveView
  use Phoenix.HTML

  def render(assigns) do
    ~L"""
    <h3>Screen brightness <%= @brightness %></h3>
    <form phx-change="update_brightness">
      <input type="range" min="1" max="255" value="<%= @brightness %>" name="brightness" class="slider" />
    </form>
    """
  end

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(%{
        brightness: KioskPhx.Backlight.brightness() 
      })

    {:ok, socket}
  end

  def handle_event("update_brightness", %{"brightness" => brightness}, socket) do
    brightness = String.to_integer(brightness)
    KioskPhx.Backlight.set_brightness(brightness)
    {:noreply, assign(socket, :brightness, brightness)}
  end
end
