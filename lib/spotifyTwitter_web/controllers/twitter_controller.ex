defmodule SpotifyTwitterWeb.TwitterController do
  use SpotifyTwitterWeb, :controller

  alias SpotifyTwitter.Twitter

  def index(conn, %{"description" => description}) do
    do_update(description, conn)
  end

  def index(conn, %{}) do
    do_update("", conn)
  end

  defp do_update(description, conn) do
    Twitter.get_twitter_description()
    |> Twitter.update_twitter_description(description)
    |> handle_response(conn)
  end

  defp handle_response("", conn), do: redirect(conn, to: "/twitter/auth")
  defp handle_response(response, conn), do: text(conn, response)
end
