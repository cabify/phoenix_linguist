defmodule PhoenixLocale.Plug do
  @moduledoc """
  Plug to check if the locale the user is trying exists, if not forward to 404

  """

  import Plug.Conn, only: [put_session: 3]
  import PhoenixLocale, only: [prefered_locale: 1, default_locale: 1]

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    case prefered_locale(conn) do
      :wrong ->
        if raise_no_available_locale(conn) do
          raise PhoenixLocale.NoAvailableLocaleError
        else
          put_locale_in_session(conn, default_locale(conn))
        end
      nil ->
        put_locale_in_session(conn, default_locale(conn))
      locale ->
        put_locale_in_session(conn, locale)

    end
  end

  defp raise_no_available_locale(_conn) do
    Application.get_env(:phoenix_locale, PhoenixLocale)
    |> Keyword.get(:raise_no_available_locale)
  end

  defp put_locale_in_session(conn, locale) do
    put_session conn, "locale", locale
  end
end
