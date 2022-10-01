defmodule SpotifyTwitterWeb.TwitterController do
  use SpotifyTwitterWeb, :controller

  alias SpotifyTwitter.Twitter

  def index(conn, _params) do
    Twitter.get_twitter_description()
    |> Twitter.update_twitter_description("")
    |> then(&text(conn, &1))
  end
end
