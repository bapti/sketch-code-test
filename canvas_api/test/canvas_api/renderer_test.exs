defmodule CanvasApi.RendererTest do
  use CanvasApi.DataCase

  alias CanvasApi.Canvases
  # alias CanvasApi.Canvases.Canvas
  # alias CanvasApi.Canvases.Rectangle
  alias CanvasApi.Renderer

  describe "Draw one rectangle" do
    @attrs %{
      rectangles: [
        %{left: 0, top: 0, width: 4, height: 4, outline: "@", fill: "@"}
      ]
    }

    @rendered_canvas [
      "@@@@",
      "@@@@",
      "@@@@",
      "@@@@"
    ]

    test "Rendered canvas should equal example" do
      {:ok, canvas} = Canvases.create_canvas(@attrs)
      assert Renderer.draw_canvas(canvas) == @rendered_canvas
    end
  end

  describe "Draw one rectangle of width and height 1" do
    @attrs %{
      rectangles: [
        %{left: 0, top: 0, width: 1, height: 1, outline: "@", fill: "@"}
      ]
    }

    @rendered_canvas [
      "@"
    ]

    test "Rendered canvas should equal example" do
      {:ok, canvas} = Canvases.create_canvas(@attrs)
      assert Renderer.draw_canvas(canvas) == @rendered_canvas
    end
  end

  describe "Draw two rectangle of width and height 2 and 3" do
    @attrs %{
      rectangles: [
        %{left: 0, top: 0, width: 2, height: 2, outline: "@", fill: "@"},
        %{left: 3, top: 0, width: 3, height: 3, outline: "@", fill: "@"}
      ]
    }

    @rendered_canvas [
      "@@ @@@",
      "@@ @@@",
      "   @@@"
    ]

    test "Rendered canvas should equal example" do
      {:ok, canvas} = Canvases.create_canvas(@attrs)
      assert Renderer.draw_canvas(canvas) == @rendered_canvas
    end
  end

  describe "Draw one rectangle on top of another" do
    @attrs %{
      rectangles: [
        %{left: 0, top: 0, width: 2, height: 2, outline: "@", fill: "@"},
        %{left: 0, top: 0, width: 3, height: 3, outline: "P", fill: "P"}
      ]
    }

    @rendered_canvas [
      "PPP",
      "PPP",
      "PPP"
    ]

    test "Rendered canvas should equal example" do
      {:ok, canvas} = Canvases.create_canvas(@attrs)
      assert Renderer.draw_canvas(canvas) == @rendered_canvas
    end
  end

  describe "Draw outline only" do
    @attrs %{
      rectangles: [
        %{left: 0, top: 0, width: 1, height: 3, outline: "S", fill: ""},
        %{left: 2, top: 0, width: 2, height: 3, outline: "K", fill: ""},
        %{left: 5, top: 0, width: 3, height: 3, outline: "E", fill: ""},
        %{left: 9, top: 0, width: 4, height: 3, outline: "T", fill: ""},
        %{left: 14, top: 0, width: 5, height: 3, outline: "C", fill: ""},
        %{left: 20, top: 0, width: 3, height: 6, outline: "H", fill: ""}
      ]
    }

    @rendered_canvas [
      "S KK EEE TTTT CCCCC HHH",
      "S KK E E T  T C   C H H",
      "S KK EEE TTTT CCCCC H H",
      "                    H H",
      "                    H H",
      "                    HHH"
    ]

    test "Rendered canvas should equal example" do
      {:ok, canvas} = Canvases.create_canvas(@attrs)
      assert Renderer.draw_canvas(canvas) == @rendered_canvas
    end
  end

  describe "Sketch supplied test fixture 1" do
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

  describe "Sketch supplied test fixture 2" do
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
