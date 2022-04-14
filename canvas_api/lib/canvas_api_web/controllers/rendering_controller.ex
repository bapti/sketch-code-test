defmodule CanvasApiWeb.RenderingController do
  use CanvasApiWeb, :controller

  alias CanvasApi.Renderer
  alias CanvasApi.Canvases
  alias CanvasApi.Canvases.Canvas

  action_fallback(CanvasApiWeb.FallbackController)

  def show(conn, %{"id" => id}) do
    canvas = Canvases.get_canvas!(id)
    rendered_canvas = Renderer.draw_canvas(canvas)
    render(conn, "show.json", canvas: canvas)
  end
end
