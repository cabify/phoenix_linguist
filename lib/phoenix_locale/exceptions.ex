defmodule PhoenixLocale.NoAvailableLocaleError do
  @moduledoc """
  Raised at runtime time when the locale is not available.
  """
  defexception [message: "Unavailable locale", plug_status: 404]
end

# See http://www.phoenixframework.org/docs/custom-errors
defimpl Plug.Exception, for: PhoenixLocale.NoAvailableLocaleError do
  def status(_exception), do: 404
end
