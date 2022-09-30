defmodule SpotifyTwitter.Spotify do
  def call(conn) do
    conn
    |> Spotify.Player.get_currently_playing()
    |> handle_response()
  end

  defp handle_response({:ok, %{"error" => %{"status" => 401}}}), do: :unauthorized

  defp handle_response({:ok, response}), do: {:ok, format_response(response.item)}

  defp handle_response(:ok), do: {:ok, "Nenhuma musica tocando no momento"}

  defp format_response(response),
    do: "#{get_music_name(response)} - #{get_artists_name(response)}"

  defp get_music_name(response), do: response.name

  defp get_artists_name(response) do
    response.artists
    |> Enum.map(& &1["name"])
    |> Enum.join(", ")
  end
end
