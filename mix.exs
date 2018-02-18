defmodule ServerTiming.MixProject do
  use Mix.Project

  def project do
    [
      app: :server_timing,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      name: "server_timing",
      source_url: "https://github.com/deftia/server_timing"
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:plug, "~> 1.4"}
    ]
  end

  defp package do
    [
      name: "server_timing",
      files: ["lib", "priv", "mix.exs", "README*", "readme", "LICENSE*", "license*"],
      maintainers: ["Abdulsattar Mohammed", "Gautham Ramachandran"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/deftia/server_timing"}
    ]
  end
end
