defmodule KioskNerves do
  @moduledoc """
  Documentation for KioskNerves.
  """
  require Logger

  @doc """
  Hello world.

  ## Examples

      iex> KioskNerves.hello
      :world

  """
  def hello do
    Logger.debug("hola")
    :world
  end
end
