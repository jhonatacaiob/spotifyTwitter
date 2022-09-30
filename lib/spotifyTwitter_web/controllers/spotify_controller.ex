defmodule SpotifyTwitterWeb.SpotifyController do
  use SpotifyTwitterWeb, :controller

  def index(conn, _params) do
    conn
    |> SpotifyTwitter.get_currently_playing_music()
    |> handle_response(conn)
  end

  def handle_response({:ok, music_name}, conn) do
    conn
    |> put_status(:ok)
    |> render("teste.json", message: music_name)
  end

  def handle_response(:unauthorized, conn), do: redirect(conn, to: "/auth")

end
