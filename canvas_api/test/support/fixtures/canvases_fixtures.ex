defmodule CanvasApi.CanvasesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CanvasApi.Canvases` context.
  """

  @doc """
  Generate a canvas.
  """
  def canvas_fixture(
        attrs \\ %{
          rectangles: [%{top: 2, left: 2, width: 2, height: 2, outline: "X", fill: "O"}]
        }
      ) do
    {:ok, canvas} =
      attrs
      |> Enum.into(%{})
      |> CanvasApi.Canvases.create_canvas()

    canvas
  end
end
