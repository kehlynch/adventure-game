defmodule Ag.Options.Option do
  @enforce_keys [:slug, :text, :type]
  defstruct slug: :init, text: :init, type: :init, direction: nil
end
