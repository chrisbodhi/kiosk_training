# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

config :kiosk_nerves, target: Mix.target()

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1582989357"

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [RingLogger]

config :webengine_kiosk, fullscreen: false

import_config "../../kiosk_phx/config/config.exs"
config :kiosk_phx, KioskPhxWeb.Endpoint,
  http: [port: 4000],
  server: true,
  code_reloader: false,
  check_origin: false,
  watchers: []

if Mix.target() != :host do
  import_config "target.exs"
end
