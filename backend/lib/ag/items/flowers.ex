defmodule Ag.Items.Flowers do
  use Ag.Items.Default,
    slug: :flowers,
    name: "A bunch of flowers",
    desc: "A small bunch of pretty wildflowers",
    options: %{
      drop: "Drop",
      sniff: "Sniff"
    }

  def apply_choice!(_pid, :sniff) do
    "The flowers smell nice"
  end
end
