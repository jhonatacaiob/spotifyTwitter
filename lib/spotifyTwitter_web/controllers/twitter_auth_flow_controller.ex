defmodule SpotifyTwitterWeb.TwitterAuthFlowController do
  use SpotifyTwitterWeb, :controller

  def authorize(conn, _params) do
    ambient_vars = get_ambient_vars()

    ExTwitter.configure(
      consumer_key: ambient_vars.consumer_key,
      consumer_secret: ambient_vars.consumer_secret,
      access_token: ambient_vars.access_token,
      access_token_secret: ambient_vars.access_token_secret
    )

    token = ExTwitter.request_token("http://localhost:4000/twitter/redirect/")

    {:ok, auth_url} = ExTwitter.authenticate_url(token.oauth_token)

    redirect(conn, external: auth_url)
  end

  def authenticate(conn, %{"oauth_token" => oauth_token, "oauth_verifier" => oauth_verifier}) do
    ambient_vars = get_ambient_vars()

    {:ok, access_token} = ExTwitter.access_token(oauth_verifier, oauth_token)

    ExTwitter.configure(
      consumer_key: ambient_vars.consumer_key,
      consumer_secret: ambient_vars.consumer_secret,
      access_token: access_token.oauth_token,
      access_token_secret: access_token.oauth_token_secret
    )

    redirect(conn, to: "/index")
  end

  def get_ambient_vars() do
    Application.fetch_env!(:extwitter, :oauth)
    |> Enum.into(%{}, fn {key, val} -> {key, val} end)
  end
end
