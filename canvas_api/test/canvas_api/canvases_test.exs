defmodule CanvasApi.CanvasesTest do
  use CanvasApi.DataCase

  alias CanvasApi.Canvases

  describe "canvases" do
    alias CanvasApi.Canvases.Canvas

    import CanvasApi.CanvasesFixtures

    @valid_attrs %{
      rectangles: [%{top: 2, left: 2, width: 2, height: 2, outline: "X", fill: "O"}]
    }

    test "list_canvases/0 returns all canvases" do
      canvas = canvas_fixture(@valid_attrs)
      assert Canvases.list_canvases() == [canvas]
    end

    test "get_canvas!/1 returns the canvas with given id" do
      canvas = canvas_fixture(@valid_attrs)
      assert Canvases.get_canvas!(canvas.id) == canvas
    end

    test "create_canvas/1 with valid data creates a canvas" do
      data = %{rectangles: [%{top: 2, left: 2, width: 2, height: 2, outline: "X", fill: "O"}]}
      assert {:ok, %Canvas{} = _canvas} = Canvases.create_canvas(data)
    end

    test "create_canvas/1 with invalid top returns error changeset" do
      data = %{rectangles: [%{top: -1, left: 2, width: 2, height: 2, outline: "X", fill: "O"}]}
      assert {:error, %Ecto.Changeset{}} = Canvases.create_canvas(data)
    end

    test "create_canvas/1 with invalid left returns error changeset" do
      data = %{rectangles: [%{top: 2, left: -2, width: 2, height: 2, outline: "X", fill: "O"}]}
      assert {:error, %Ecto.Changeset{}} = Canvases.create_canvas(data)
    end

    test "create_canvas/1 with invalid width returns error changeset" do
      data = %{rectangles: [%{top: 2, left: 2, width: 0, height: 2, outline: "X", fill: "O"}]}
      assert {:error, %Ecto.Changeset{}} = Canvases.create_canvas(data)
    end

    test "create_canvas/1 with invalid height returns error changeset" do
      data = %{rectangles: [%{top: 1, left: 2, width: 2, height: 0, outline: "X", fill: "O"}]}
      assert {:error, %Ecto.Changeset{}} = Canvases.create_canvas(data)
    end

    test "create_canvas/1 with missing fill and outline returns error changeset" do
      data = %{rectangles: [%{top: 2, left: 2, width: 2, height: 2}]}
      assert {:error, %Ecto.Changeset{}} = Canvases.create_canvas(data)
    end

    test "create_canvas/1 with empty fill and outline returns error changeset" do
      data = %{rectangles: [%{top: 2, left: 2, width: 2, height: 2, outline: "", fill: ""}]}
      assert {:error, %Ecto.Changeset{}} = Canvases.create_canvas(data)
    end

    test "update_canvas/2 with valid data updates the canvas" do
      canvas = canvas_fixture(@valid_attrs)

      update_attrs = %{
        rectangles: [%{top: 3, left: 4, width: 1, height: 3, outline: "R", fill: "S"}]
      }

      assert {:ok, %Canvas{} = _canvas} = Canvases.update_canvas(canvas, update_attrs)
    end

    test "update_canvas/2 with invalid data returns error changeset" do
      canvas = canvas_fixture(@valid_attrs)
      data = %{rectangles: [%{outline: "", fill: ""}]}
      assert {:error, %Ecto.Changeset{}} = Canvases.update_canvas(canvas, data)
      assert canvas == Canvases.get_canvas!(canvas.id)
    end

    test "delete_canvas/1 deletes the canvas" do
      canvas = canvas_fixture()
      assert {:ok, %Canvas{}} = Canvases.delete_canvas(canvas)
      assert_raise Ecto.NoResultsError, fn -> Canvases.get_canvas!(canvas.id) end
    end

    test "change_canvas/1 returns a canvas changeset" do
      canvas = canvas_fixture()
      assert %Ecto.Changeset{} = Canvases.change_canvas(canvas)
    end
  end
end
