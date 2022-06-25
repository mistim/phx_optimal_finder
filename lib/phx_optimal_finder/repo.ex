defmodule PhxOptimalFinder.Repo do
  use Ecto.Repo,
    otp_app: :phx_optimal_finder,
    adapter: Ecto.Adapters.MyXQL
end
