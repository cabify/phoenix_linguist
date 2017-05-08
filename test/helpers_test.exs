defmodule PhoenixLocaleHelpersTest do
  use ExUnit.Case

  import PhoenixLocale.Helpers

  setup_all do
    Application.put_env(:phoenix_locale, PhoenixLocale, %{i18n: PhoenixLocaleTest.I18n})
    :ok
  end

  setup do
    conn = %Plug.Conn{params: %{}, private: %{phoenix_endpoint: PhoenixLocale, plug_session: %{}}}
    {:ok, conn: conn}
  end

  test "t defaults to default locale when none availavble", context do
    assert t(context.conn, "flash.notice.hello") == "salut"
  end

  test "t returns empty string when there's no translation", context do
    assert t(context.conn, "flash.notice.bye") == ""
  end

  test "l returns default locale if prefered_locale is not available", context do
    assert l(context.conn) == "fr"
  end
end
