defmodule Ag.Places.PlaceBehaviour do
  @callback get_entry_option(pid())::{String.t(), String.t()}
  @callback get_remote_desc(pid())::String.t()
end
