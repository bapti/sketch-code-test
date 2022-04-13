defmodule CanvasApiWeb.CanvasControllerTest do
  use CanvasApiWeb.ConnCase

  import CanvasApi.CanvasesFixtures

  alias CanvasApi.Canvases.Canvas

  @create_attrs %{
    rectangles: [%{top: 2, left: 2, width: 2, height: 2, outline: "X", fill: "O"}]
  }
  @update_attrs %{}
  @invalid_attrs %{
    rectangles: [%{top: 0, left: 2, width: 2, height: 2, outline: "", fill: ""}]
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all canvases", %{conn: conn} do
      conn = get(conn, Routes.canvas_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create canvas" do
    test "renders canvas when data is valid", %{conn: conn} do
      conn = post(conn, Routes.canvas_path(conn, :create), canvas: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.canvas_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.canvas_path(conn, :create), canvas: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update canvas" do
    setup [:create_canvas]

    test "renders canvas when data is valid", %{conn: conn, canvas: %Canvas{id: id} = canvas} do
      conn = put(conn, Routes.canvas_path(conn, :update, canvas), canvas: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.canvas_path(conn, :show, id))

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, canvas: canvas} do
      conn = put(conn, Routes.canvas_path(conn, :update, canvas), canvas: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete canvas" do
    setup [:create_canvas]

    test "deletes chosen canvas", %{conn: conn, canvas: canvas} do
      conn = delete(conn, Routes.canvas_path(conn, :delete, canvas))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, Routes.canvas_path(conn, :show, canvas))
      end)
    end
  end

  defp create_canvas(_) do
    canvas = canvas_fixture()
    %{canvas: canvas}
  end
end
