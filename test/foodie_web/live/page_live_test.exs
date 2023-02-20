defmodule FoodieWeb.PageLiveTest do
  use FoodieWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  alias FoodieWeb.PageLive.Index

  defp do_mount(conn) do
    {:ok, view, html} = live_isolated(conn, Index)

    {view, html}
  end

  describe "mount/2" do
    test "liveview should mount to the page and render google api", %{conn: conn} do
      {view, _html} = do_mount(conn)

      {:ok, html} = view |> render() |> Floki.parse_document()

      assert html |> Floki.find("#food-button") |> Floki.text() == "Find me some FOOD!!!"
      google_api = html |> Floki.find("script") |> Floki.attribute("src") |> Floki.text()
      assert String.contains?(google_api, "maps.googleapis.com") == true
    end
  end
end
