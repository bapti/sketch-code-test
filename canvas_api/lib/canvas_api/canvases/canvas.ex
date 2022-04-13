defmodule CanvasApi.Canvases.Canvas do
  use Ecto.Schema
  import Ecto.Changeset
  alias CanvasApi.Canvases.Rectangle

  schema "canvases" do
    embeds_many(:rectangles, Rectangle, on_replace: :delete)

    timestamps()
  end

  @doc false
  def changeset(canvas, attrs) do
    canvas
    |> cast(attrs, [])
    |> cast_embed(:rectangles, required: true, with: &Rectangle.changeset/2)
    |> validate_required([:rectangles])
  end
end
