defmodule CanvasApi.Repo do
  use Ecto.Repo,
    otp_app: :canvas_api,
    adapter: Ecto.Adapters.SQLite3
end
