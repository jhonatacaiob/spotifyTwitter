defmodule SpotifyTwitterWeb.SpotifyTwitterController do
  use SpotifyTwitterWeb, :controller

  alias SpotifyTwitter.SpotifyTwitterGenserver, as: Genserver

  def index(conn, _params) do
    redirect(conn, to: "/twitter/auth/")
  end

  def start_gen(conn, _params) do
    {:ok, _pid} = Genserver.start_link(conn)

    text(conn, "Aplicação iniciada")
  end
end
