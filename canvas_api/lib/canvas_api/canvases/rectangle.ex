defmodule CanvasApi.Canvases.Rectangle do
  use Ecto.Schema
  import Ecto.Changeset
  alias CanvasApi.Canvases.Rectangle

  embedded_schema do
    field(:top, :integer)
    field(:left, :integer)
    field(:width, :integer)
    field(:height, :integer)
    field(:outline, :string)
    field(:fill, :string)
  end

  def changeset(%Rectangle{} = rectangle, attrs) do
    rectangle
    |> cast(attrs, [:top, :left, :width, :height, :outline, :fill])
    |> validate_required([:top, :left, :width, :height])
    |> validate_number(:top, greater_than_or_equal_to: 1)
    |> validate_number(:left, greater_than_or_equal_to: 1)
    |> validate_number(:width, greater_than_or_equal_to: 1)
    |> validate_number(:height, greater_than_or_equal_to: 1)
    |> validate_outline_and_fill()
  end

  def validate_outline_and_fill(changeset) do
    outline_valid = get_field(changeset, :outline) |> is_valid?()
    fill_valid = get_field(changeset, :fill) |> is_valid?()

    if outline_valid or fill_valid do
      changeset
    else
      # Add the error to the first field only since Ecto requires a field name for each error.
      add_error(changeset, :outline, "One of :outline or :fill must be present")
    end
  end

  def is_valid?(value) do
    value != nil and value != "" and String.length(value) == 1
  end
end
