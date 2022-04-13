defmodule CanvasApi.Repo.Migrations.CreateCanvases do
  use Ecto.Migration

  def change do
    create table(:canvases) do
      add(:rectangles, {:array, :map})

      timestamps()
    end
  end
end
