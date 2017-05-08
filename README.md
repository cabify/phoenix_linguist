[![Build Status](https://travis-ci.org/cabify/phoenix_locale.svg?branch=master)](https://travis-ci.org/cabify/phoenix_locale)

# PhoenixLocale

Locale functions to be integrated into [Phoenix](http://github.com/phoenixframework/phoenix) providing a plug and view helpers

`PhoenixLocalePlug` checks if there's a :locale param on the requested route, if there is and matches the existing locales, puts the locale on the session. If there isn't a :locale defined, `PhoenixLocalePlug` puts the default locale on the session. If the requested :locale does not exist, puts the default locale on the session. `PhoenixLocale.Helpers` are a couple of view helpers that can be used on templates to help determine user's preferred locale.

You can see the [online documentation](http://hexdocs.pm/phoenix_locale/) for more information.

## Requirements

Elixir 1.4.2

[Phoenix](http://www.phoenixframework.org) 1.2.1

## Instructions

Define your I18n Module on `config.ex`

```elixir
config :phoenix_locale, PhoenixLocale,
  i18n: MyApp.I18n
```

If you want a 404 error when no available local is found just need to configure as:

```elixir
config :phoenix_locale, PhoenixLocale,
  i18n: MyApp.I18n, raise_no_available_locale: true
```

Add `PhoenixLocale.Plug` to the plug list on your routes file, on the browser pipeline after Phoenix plugs

```elixir
  pipeline :browser do
    plug :accepts, ~w(html)
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug PhoenixLocale.Plug
  end
```

If you need to use the helper functions, add `PhoenixLocale.Helpers` to your web module:

```elixir
  def view do
    quote do
      use Phoenix.View, root: "web/templates"

      import MyAPP.Router.Helpers
      use Phoenix.HTML
      import PhoenixLocale.Helpers
    end
  end

```

Check the [online documentation](http://hexdocs.pm/phoenix_locale/PhoenixLocale.Helpers.html) for the list of helpers available
