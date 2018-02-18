defmodule ServerTiming.MixProject do
  use Mix.Project

  @version "0.1.3"

  def project do
    [
      app: :server_timing,
      version: @version,
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: description(),
      deps: deps(),
      package: package(),
      name: "server_timing",
      docs: docs_config()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:plug, "~> 1.4"},
      {:ex_doc, "~> 0.13", only: :dev},
    ]
  end

  defp description do
    """
    Simple Plug for Server Timing
    """
  end

  defp docs_config do
    [extras: ["README.md": [title: "Overview", path: "api-reference"]],
     main: "api-reference",
     source_ref: "v#{@version}",
     source_url: "https://github.com/deftia/server_timing"]
  end

  defp package do
    [
      name: "server_timing",
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Abdulsattar Mohammed", "Gautham Ramachandran"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/deftia/server_timing"}
    ]
  end
end
