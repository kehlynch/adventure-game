defmodule Ag.Items.Sword do
  use Ag.Items.Default, slug: :sword

  @impl true
  def get_name(pid) do
    case get_setting(pid, :rusty) do
      true -> "rusty iron sword"
      _ -> "iron sword"
    end
  end

  @impl true
  def get_desc(pid) do
    case get_setting(pid, :rusty) do
      true -> "rusty iron sword"
      _ -> "iron sword"
    end
  end
end
