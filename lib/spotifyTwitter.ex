defmodule SpotifyTwitter do
  @moduledoc """
  SpotifyTwitter keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate get_currently_playing_music(conn), to: SpotifyTwitter.Spotify, as: :call
end
