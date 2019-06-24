defmodule Ag.Factory do
  use ExMachina

  def item_factory do
    %Ag.Items.Item{
      slug: sequence(:slug, &"slug-#{&1}"),
      name: sequence(:name, &"name-#{&1}"),
      desc: sequence(:desc, &"desc-#{&1}"),
      options: []
    }
  end
end
