defmodule PhoenixLocale.Helpers do
  @moduledoc """
  helper functions to use on views
  """

  import PhoenixLocale, only: [prefered_locale: 1, default_locale: 1, i18n: 1]

  @doc """
  translate given string with the apropriated locale, return empty string if the translation string doesn't exist
  """
  def t(conn, string, bindings \\ []) do
    case prefered_locale(conn) do
      nil ->
        case i18n(conn).t(default_locale(conn), string, bindings) do
          {:ok, translation} -> translation
          {:error, _} -> ""
        end
      locale ->
        case i18n(conn).t(locale, string, bindings) do
          {:ok, translation} -> translation
          {:error, _} -> ""
        end
    end
  end

  @doc """
  call prefered_locale, if the result is nil, return the default locale
  """
  def l(conn) do
    case prefered_locale(conn) do
      nil ->
        default_locale(conn)
      locale ->
        locale
    end
  end
end
