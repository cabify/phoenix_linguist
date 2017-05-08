defmodule PhoenixLocale.Mixfile do
  use Mix.Project

  def project do
    [app: :phoenix_locale,
     version: "0.0.1",
     elixir: "~> 1.4",
     description: description(),
     package: package(),
     test_coverage: [tool: ExCoveralls],
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: applications(Mix.env)]
  end

  defp applications(:test) do
    [:phoenix, :phoenix_html] ++ applications(:prod)
  end

  defp applications(_) do
    [:logger]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:phoenix, "~> 1.2"},
     {:phoenix_html, "~> 2.1"},
     {:cowboy, "~> 1.0"},
     {:earmark, "~> 0.1", only: :dev},
     {:ex_doc, "~> 0.11", only: :dev},
     {:excoveralls, "~> 0.4", only: :test}
    ]
  end

  defp description do
    "Locale functions to be integrated into Phoenix projects, providing a plug and view helpers. Started from https://github.com/jxs/phoenix_linguist"
  end

  defp package do
    [files: ["lib", "mix.exs", "README*", "LICENSE*"],
     maintainers: ["Paco Guzmán"],
     contributors: ["Paco Guzmán", "Joao Oliveira"],
     licenses: ["MIT"],
     links: %{"GitHub" => "https://github.com/cabify/phoenix_locale"}
    ]
  end
end
