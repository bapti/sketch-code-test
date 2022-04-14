defmodule CanvasApi.RendererTest do
  use CanvasApi.DataCase

  alias CanvasApi.Canvases
  # alias CanvasApi.Canvases.Canvas
  # alias CanvasApi.Canvases.Rectangle
  alias CanvasApi.Renderer

  describe "Test fixture 1" do
    @attrs %{
      rectangles: [
        %{left: 3, top: 2, width: 5, height: 3, outline: "@", fill: "X"},
        %{left: 10, top: 3, width: 14, height: 6, outline: "X", fill: "O"}
      ]
    }

    @rendered_canvas [
      "                        ",
      "                        ",
      "   @@@@@                ",
      "   @XXX@  XXXXXXXXXXXXXX",
      "   @@@@@  XOOOOOOOOOOOOX",
      "          XOOOOOOOOOOOOX",
      "          XOOOOOOOOOOOOX",
      "          XOOOOOOOOOOOOX",
      "          XXXXXXXXXXXXXX"
    ]

    test "Rendered canvas should equal example" do
      {:ok, canvas} = Canvases.create_canvas(@attrs)
      assert Renderer.draw_canvas(canvas) == @rendered_canvas
    end
  end

  describe "Test fixture 2" do
    @attrs %{
      rectangles: [
        %{left: 14, top: 0, width: 7, height: 6, outline: "", fill: "."},
        %{left: 0, top: 3, width: 8, height: 4, outline: "O", fill: ""},
        %{left: 5, top: 5, width: 5, height: 3, outline: "X", fill: "X"}
      ]
    }

    @rendered_canvas [
      "              .......",
      "              .......",
      "              .......",
      "OOOOOOOO      .......",
      "O      O      .......",
      "O    XXXXX    .......",
      "OOOOOXXXXX           ",
      "     XXXXX           "
    ]

    test "Rendered canvas should equal example" do
      {:ok, canvas} = Canvases.create_canvas(@attrs)
      assert Renderer.draw_canvas(canvas) == @rendered_canvas
    end
  end
end
