defmodule FoodieWeb.PageLive.Index do
  use FoodieWeb, :live_view

  alias NimbleCSV.RFC4180, as: CsvParser

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_event("get_data", _params, socket) do
    data = fetch_food_truck_data()

    {:noreply, push_event(socket, "food_truck_locations", %{location: data})}
  end

  defp fetch_food_truck_data() do
    File.stream!("Mobile_Food_Facility_Permit.csv")
    |> CsvParser.parse_stream(skip_headers: false)
    |> Stream.filter(fn
      [_, _, "Push Cart" | _] -> false
      [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _,
      _, _, "ExpirationDate", _] -> false
      _ -> true
    end)
    |> Enum.filter(fn
      [_, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _, _,
      _, _, expiration_date, _] ->
        if String.length(expiration_date) !== 0 do
          {:ok, result} = Timex.parse(expiration_date, "{0M}/{D}/{YYYY} {h24}:{m}:{s} AM")
          result.year == 2023
        end
    end)
    |> Enum.map(fn
      [_, applicant, _, _, _, address, _, _, _, _, _, food, _, _, latitude, longitude | _] ->
        %{
          applicant: applicant,
          latitude: latitude,
          longitude: longitude,
          address: address,
          food: food
        }
    end)
    |> Enum.dedup()
  end
end
