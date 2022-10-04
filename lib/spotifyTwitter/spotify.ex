defmodule SpotifyTwitter.Spotify do
  def get_music(conn) do
    # try do
    conn
    |> Spotify.Player.get_currently_playing()
    |> handle_response()

    # rescue
    #   AuthenticationError -> {:unauthorized}
    # end
  end

  defp handle_response({:ok, %{"error" => %{"status" => 401}}}), do: :unauthorized

  defp handle_response({:ok, %{"error" => %{"status" => 400}}}), do: :bad_request

  defp handle_response({:ok, %{"error" => %{"status" => 503}}}), do: :service_unavailable

  defp handle_response({:ok, %{"error" => %{"status" => 500}}}), do: :internal_server_error

  defp handle_response(:ok), do: {:ok, ""}

  defp handle_response({:ok, %{item: nil}}), do: {:ok, "Ouvindo um podcast..."}

  defp handle_response({:ok, %{item: item}}), do: {:ok, get_music_name(item)}

  defp handle_response({:error, :timeout}), do: {:ok, ""}

  defp get_music_name(%{name: name, artists: artists}),
    do: "#{name} - #{get_artists_name(artists)}"

  defp get_artists_name(artists) do
    artists
    |> Enum.map_join(", ", & &1["name"])
  end
end
