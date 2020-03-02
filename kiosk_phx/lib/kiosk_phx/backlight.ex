defmodule KioskPhx.Backlight do
  use GenServer

  @brightness_file "/sys/class/backlight/rpi_backlight/brightness"

  # Public API

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def set_brightness(value) when value >= 0 and value <= 255 do
    GenServer.call(__MODULE__, {:brightness, value})
  end

  def set_brightness(value) do
    {:error, "Value must be >=0 and <= 255; you entered #{value}"}
   end

  def brightness do
    GenServer.call(__MODULE__, :brightness)
  end

  # GenServer Callbacks

  def init(_opts) do
    {:ok, 255}
  end

  def handle_call(:brightness, _from, brightness) do
    {:reply, brightness, brightness}
  end

  def handle_call({:brightness, value}, _from, _brightness) do
    # check for the file so we can run this code on our host machine without crashing
    if File.exists?(@brightness_file) do
      value = value |> round()
      File.write(@brightness_file, value |> to_string())
    end
    {:reply, value, value}
  end
end
