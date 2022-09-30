defmodule SpotifyTwitterWeb.SpotifyAuthFlowController do
  use SpotifyTwitterWeb, :controller

  def authorize(conn, _params) do
    redirect(conn, external: Spotify.Authorization.url())
  end

  def authenticate(conn, params) do
    case Spotify.Authentication.authenticate(conn, params) do
      {:ok, conn} -> redirect(conn, to: "/get_name_music")
      {:error, reason, conn} -> redirect(conn, to: "/error")
    end
  end
end
