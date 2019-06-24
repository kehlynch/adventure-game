defmodule Ag.Repo.Factory do
  use ExMachina.Ecto, repo: Ag.Repo

  def user_factory do
    %Ag.Users.User{
      email_address: sequence(:email_address, &"email-#{&1}@example.com")
    }
  end

  def store_factory do
    %Ag.Stores.Store{
      data: %{}
    }
  end
end
