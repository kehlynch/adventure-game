defmodule Ag.Expanses.ExpanseBehaviour do
  @callback init(pid())::none()
  @callback get_exits_desc(pid())::String.t()
end
