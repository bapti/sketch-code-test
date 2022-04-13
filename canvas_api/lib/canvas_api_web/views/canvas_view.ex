defmodule CanvasApiWeb.CanvasView do
  use CanvasApiWeb, :view
  alias CanvasApiWeb.CanvasView

  def render("index.json", %{canvases: canvases}) do
    %{data: render_many(canvases, CanvasView, "canvas.json")}
  end

  def render("show.json", %{canvas: canvas}) do
    %{data: render_one(canvas, CanvasView, "canvas.json")}
  end

  def render("canvas.json", %{canvas: canvas}) do
    %{
      id: canvas.id
    }
  end
end
