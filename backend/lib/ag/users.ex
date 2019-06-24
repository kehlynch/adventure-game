defmodule Ag.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ag.Users.User

  schema "users" do
    field :email_address, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs \\ %{}) do
    user
    |> cast(attrs, [:email_address])
    |> validate_required([:email_address])
  end
end

defmodule Ag.Users do
  import Ecto.Query, warn: false
  alias Ag.Repo

  alias Ag.Stores
  alias Ag.Users.User

  # User actions

  def list_users do
    Repo.all(User)
  end

  def get_user!(id) do
    User
    |> Repo.get!(id)
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_or_create_user!(attrs) do
    case Repo.get_by(User, attrs) do
      nil -> create_user!(attrs)
      %User{} = user -> user
    end
  end

  def get_user_by_email!(email) do
    Repo.get_by!(User, %{email_address: email})
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def create_user!(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert!()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    user
    |> Ecto.Changeset.change()
    |> Repo.delete()
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def list_user_stores(user_id) do
    user_id
    |> Stores.get_user_stores()
  end
end
