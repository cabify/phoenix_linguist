defmodule PhoenixLocaleTest.I18n do
  def locales do
    ~w(fr es en)
  end

  def default_locale do
    "fr"
  end

  # Example implementation for testing helpers and to show what is expect to provide
  def t("fr", "flash.notice.hello", []), do: {:ok, "salut"}
  def t("fr", "flash.notice.bye", []), do: {:ok, ""}
  def t(_locale, _string, _bindings) do
    {:ok, "wadus"}
  end
end
