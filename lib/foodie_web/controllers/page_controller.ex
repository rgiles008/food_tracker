defmodule FoodieWeb.PageController do
  use FoodieWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
