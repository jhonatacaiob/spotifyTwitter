defmodule SpotifyTwitter.SpotifyTwitterGenserver do
  use GenServer

  alias SpotifyTwitter.{Spotify, Twitter}

  # Client
  def start_link(conn) do
    GenServer.start_link(__MODULE__, conn)
  end

  # Server (callbacks)

  @impl true
  def init(conn) do
    schedule_work()

    {:ok, conn}
  end

  @impl true
  def handle_info(:work, conn) do
    schedule_work()
    {:ok, music_name} = Spotify.get_music(conn) |> IO.inspect(label: "music_name")

    Twitter.get_twitter_description()
    |> Twitter.update_twitter_description(music_name)
    |> IO.inspect(label: "description")

    {:noreply, conn}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 10 * 1000)
  end
end
