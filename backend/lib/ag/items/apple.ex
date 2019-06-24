defmodule Ag.Items.Apple do
  alias Ag.Settings.Status
  use Ag.Items.Default,
    slug: :apple,
    name: "apple",
    desc: "A shiny red apple",
    options: %{
      eat: "Eat",
      drop: "Drop"
    },
    stack: true
  
  @impl true
  def get_name(pid) do
    "#{get_setting(pid, :count)} apples"
  end

  @impl true
  def apply_choice!(pid, %{slug: :eat}) do
    Status.increment_hunger!(pid, -3)
    add(pid, -1)
    "You feel a bit less hungry"
  end

  @impl true
  def apply_choice!(pid, %{slug: :drop}) do
    add(pid, -1)
    "You drop an apple"
  end
end
