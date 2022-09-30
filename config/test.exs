import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :spotifyTwitter, SpotifyTwitterWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "aHLXWSt5tDlgHerPSn2BTQ/d2mzShov47LBZokO38yF5/ExPlS+pNirp+Rh0VCuQ",
  server: false

# In test we don't send emails.
config :spotifyTwitter, SpotifyTwitter.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
