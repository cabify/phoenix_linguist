defmodule PhoenixLocalePlugTest do
  use ExUnit.Case
  use Plug.Test

  import Plug.Conn

  setup do
    Application.put_env(:phoenix_locale, PhoenixLocale, %{i18n: PhoenixLocaleTest.I18n})
    conn = conn(:get, "/")
    conn = %Plug.Conn{conn | params: %{}, private: %{phoenix_endpoint: __MODULE__, plug_session: %{}}}
    {:ok, conn: conn}
  end

  test "plug call puts default locale if prefered_local returns :nil", context do
    conn = PhoenixLocale.Plug.call(context.conn, [])
    assert get_session(conn, "locale") == "fr"
  end

  test "plug call puts default locale if prefered_local returns :wrong (not in available locales)", context do
    conn = %Plug.Conn{context.conn | params: %{"locale"=> "pt"}}
    conn = PhoenixLocale.Plug.call(conn, [])
    assert get_session(conn, "locale") == "fr"
  end

  test "plug call puts locale if prefered_local returns that locale", context do
    conn = %Plug.Conn{context.conn | params: %{"locale"=> "en"}}
    conn = PhoenixLocale.Plug.call(conn, [])
    assert get_session(conn, "locale") == "en"
  end

  test "plug call puts 404 status and renders ErrorView if prefered_local returns :wrong (not in available locales)", context do
    Application.put_env(:phoenix_locale, PhoenixLocale, %{i18n: PhoenixLocaleTest.I18n, raise_no_available_locale: true})
    conn = %Plug.Conn{context.conn | params: %{"locale"=> "pt"}}

    assert_raise PhoenixLocale.NoAvailableLocaleError, fn ->
      PhoenixLocale.Plug.call(conn, [])
    end
  end
end
