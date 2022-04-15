defmodule CanvasApi.Renderer do
  alias CanvasApi.Canvases.Canvas

  def draw_canvas(%Canvas{} = canvas) do
    {width, height} = limits(canvas)

    array_canvas =
      Arrays.new(for _y <- 0..height, do: Arrays.new(0..width |> Enum.map(fn _ -> " " end)))

    draw_rectangles_to_canvas(canvas.rectangles, array_canvas)
    |> Arrays.map(fn row -> Arrays.reduce(row, "", &(&2 <> &1)) end)
    |> Enum.into([])
  end

  defp draw_rectangles_to_canvas([], array_canvas), do: array_canvas

  defp draw_rectangles_to_canvas([rect | tail], array_canvas) do
    right = rect.left + rect.width - 1
    bottom = rect.top + rect.height - 1
    coords = for x <- rect.left..right, y <- rect.top..bottom, do: {x, y, draw_char(x, y, rect)}
    array_canvas = draw_coords_to_canvas(coords, array_canvas)

    draw_rectangles_to_canvas(tail, array_canvas)
  end

  defp draw_coords_to_canvas([], array_canvas), do: array_canvas

  defp draw_coords_to_canvas([{x, y, char} | tail], array_canvas) do
    array_canvas = put_in(array_canvas[y][x], char)
    draw_coords_to_canvas(tail, array_canvas)
  end

  defp draw_char(x, y, %{top: t, left: l, width: w, height: h, outline: outline, fill: fill})
       when y == t or y == t + h - 1 or x == l or x == l + w - 1 do
    case outline do
      "" -> fill
      _ -> outline
    end
  end

  defp draw_char(_x, _y, %{fill: ""}), do: " "
  defp draw_char(_x, _y, %{fill: fill}), do: fill

  defp limits(canvas) do
    canvas.rectangles
    |> Enum.reduce(
      {0, 0},
      fn %{top: t, left: l, width: w, height: h}, {max_w, max_h} ->
        max_w = max(max_w, l + w - 1)
        max_h = max(max_h, t + h - 1)
        {max_w, max_h}
      end
    )
  end
end
