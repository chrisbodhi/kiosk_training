defmodule KioskNerves.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    target() |> platform_init()

    webengine_kiosk_opts = Application.get_all_env(:webengine_kiosk)
    
    opts = [strategy: :one_for_one, name: KioskNerves.Supervisor]
    children =
      [
        # Children for all targets
        {WebengineKiosk, {webengine_kiosk_opts, [name: Display]}}
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: KioskNerves.Worker.start_link(arg)
      # {KioskNerves.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: KioskNerves.Worker.start_link(arg)
      # {KioskNerves.Worker, arg},
    ]
  end

  def target() do
    Application.get_env(:kiosk_nerves, :target)
  end

  defp platform_init(:host), do: :ok

  defp platform_init(_target) do
    # initialize udev
    :os.cmd('udevd -d')
    :os.cmd('udevadm trigger --type=subsystems --action=add')
    :os.cmd('udevadm trigger --type=devices --action=add')
    :os.cmd('udevadm settle --timeout=30')

    # Start socat
    System.put_env("QTWEBENGINE_REMOTE_DEBUGGING", "9222")
    MuonTrap.Daemon.start_link("socat", ["tcp-listen:9223,fork", "tcp:localhost:9222"])
  end
end
