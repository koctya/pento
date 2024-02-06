defmodule Pento.Survey.Demographic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Hex.API.User
  alias Pento.Accounts.User

  schema "demographics" do
    field :gender, :string
    field :year_of_birth, :integer
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(demographic, attrs) do
    demographic
    |> cast(attrs, [:gender, :year_of_birth])
    |> validate_required([:gender, :year_of_birth])
    |> validate_inclusion(:gender,
      ["male", "female", "prefer not to say"])
    |> validate_inclusion(:year_of_birth,
      1920..2023)
    |> unique_constraint(:user_id)
  end
end
