defmodule Ag.Items.Coins do
  use Ag.Items.Default,
    slug: :coins,
    starting_inv: true

  @impl true
  def init!(pid) do
    super(pid)
    set_value!(pid, 20)
  end

  @impl true
  def get_name(pid) do
    "#{get_value(pid)} silver coins"
  end

  @impl true
  def get_desc(pid) do
    "An assortment of small metal coins, worth a total of #{get_value(pid)} silver"
  end

  defp set_value!(pid, value) do
    set_setting!(pid, :value, value)
  end

  defp get_value(pid) do
    get_setting(pid, :value)
  end
end
