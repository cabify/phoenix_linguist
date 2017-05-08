defmodule PhoenixLocaleTest do
  use ExUnit.Case

  import PhoenixLocale
  import Plug.Conn

  setup_all do
    Application.put_env(:phoenix_locale, PhoenixLocale, %{i18n: PhoenixLocaleTest.I18n})
    :ok
  end

  setup do
    conn = %Plug.Conn{params: %{}, private: %{phoenix_endpoint: PhoenixLocale, plug_session: %{}}}
    {:ok, conn: conn}
  end

  test "params_locale returns :wrong if params locale doesn't exist", context do
    conn = %Plug.Conn{context.conn | params: %{"locale"=> "pt"}}
    assert params_locale(conn) == :wrong
  end

  test "params_locale returns :nil when params locale doesn't exist", context do
    conn = %Plug.Conn{context.conn | params: %{}}
    assert params_locale(conn) == nil
  end

  test "params_locale returns locale when params locale exists", context do
    conn = %Plug.Conn{context.conn | params: %{"locale"=> "en"}}
    assert params_locale(conn) == "en"
  end

  test "default_locale returns first locale added", context do
    assert default_locale(context.conn) == "fr"
  end

  test "session_locale returns session locale", context do
    conn = put_session(context.conn, "locale", "en")
    assert session_locale(conn) == "en"
  end

  test "req_header_locale returns first request header locale", context do
    conn = %Plug.Conn{context.conn | req_headers: [{"accept-language", "en-US,en;q=0.8,pt;q=0.6"}]}
    assert req_header_locale(conn) == "en"
  end

  test "req_header_locale returns second request header locale", context do
    conn = %Plug.Conn{context.conn | req_headers: [{"accept-language", "pt-PT,en;q=0.8,pt;q=0.6"}]}
    assert req_header_locale(conn) == "en"
  end

  test "prefered_locale returns params_locale first", context do
    conn = %Plug.Conn{context.conn | params: %{"locale"=> "en"}}
    assert prefered_locale(conn) == "en"
  end

  test "prefered_locale returns session_locale second", context do
    conn = put_session(context.conn, "locale", "fr")
    assert prefered_locale(conn) == "fr"
  end

  test "prefered_locale returns req_header_locale third", context do
    conn = %Plug.Conn{context.conn | req_headers: [{"accept-language", "fr-FR,en;q=0.8,pt;q=0.6"}]}
    assert prefered_locale(conn) == "fr"
  end

  test "prefered_locale returns nil if none match", context do
    assert prefered_locale(context.conn) == nil
  end
end
