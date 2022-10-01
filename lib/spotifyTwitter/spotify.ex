defmodule SpotifyTwitter.Spotify do
  def get_music(conn) do
    conn
    |> Spotify.Player.get_currently_playing()
    |> handle_response()
  end

  defp handle_response({:ok, %{"error" => %{"status" => 401}}}), do: :unauthorized

  defp handle_response(:ok), do: {:ok, ""}

  defp handle_response({:ok, %{item: nil}}), do: {:ok, "Ouvindo um podcast..."}

  defp handle_response({:ok, %{item: item}}), do: {:ok, get_music_name(item)}

  defp get_music_name(%{name: name, artists: artists}),
    do: "#{name} - #{get_artists_name(artists)}"

  defp get_artists_name(artists) do
    artists
    |> Enum.map(& &1["name"])
    |> Enum.join(", ")
  end
end
