defmodule SpotifyTwitterWeb.SpotifyController do
  use SpotifyTwitterWeb, :controller

  alias SpotifyTwitter.Spotify

  def index(conn, _params) do
    conn
    |> Spotify.get_music()
    |> handle_response(conn)
  end

  def handle_response({:ok, music_name}, conn) do
    conn
    |> put_status(:ok)
    |> render("teste.json", message: music_name)
  end

  def handle_response(:unauthorized, conn), do: redirect(conn, to: "/spotify/auth")
  def handle_response(:bad_request, conn), do: redirect(conn, to: "/spotify/auth")
end
