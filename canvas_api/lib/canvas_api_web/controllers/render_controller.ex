defmodule CanvasApiWeb.RenderController do
  use CanvasApiWeb, :controller

  alias CanvasApi.Renderer
  alias CanvasApi.Canvases
  alias CanvasApi.Canvases.Canvas

  action_fallback(CanvasApiWeb.FallbackController)

  def show(conn, %{"id" => id}) do
    canvas = Canvases.get_canvas!(id)
    rendered_canvas = Renderer.draw_canvas(canvas)

    conn
    |> put_resp_header("content-type", "application/json; charset=utf-8")
    |> send_resp(200, Jason.encode!(%{data: rendered_canvas}, pretty: true))
  end
end
