defmodule SpotifyTwitter.Twitter do
  import ExTwitter.API.Base

  @string_divider " | "

  def execute_function(function) do
    try do
      function.()
      |> Map.get(:description)
    rescue
      e in ExTwitter.Error ->
        case e.code do
          89 -> {""}
        end
    end
  end

  def get_twitter_description() do
    execute_function(fn -> ExTwitter.verify_credentials() end)
  end

  def update_twitter_description(description, "") do
    description
    |> get_first_part_of_description()
    |> update_profile_description()
  end

  def update_twitter_description(description, new_music) do
    description
    |> get_first_part_of_description()
    |> Kernel.<>(@string_divider <> new_music)
    |> update_profile_description()
  end

  def get_first_part_of_description(actual_description) do
    actual_description
    |> String.split(@string_divider)
    |> hd()
  end

  defp update_profile_description(description) do
    execute_function(fn ->
      request(
        :post,
        "1.1/account/update_profile.json",
        description: description
      )
    end)
  end
end
