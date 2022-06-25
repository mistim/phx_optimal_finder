defmodule PhxOptimalFinderWeb.PageController do
  use PhxOptimalFinderWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
