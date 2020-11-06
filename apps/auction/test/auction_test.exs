defmodule AuctionTest do
  use ExUnit.Case
  alias Auction.{Repo, Item}
  doctest Auction

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "list_items/0" do
    setup do
      {:ok, item1} = Repo.insert(%Item{title: "item 1"})
      {:ok, item2} = Repo.insert(%Item{title: "item 2"})
      {:ok, item3} = Repo.insert(%Item{title: "item 3"})
      %{items: [item1, item2, item3]}
    end

    test "returns all items in the database", %{items: items} do
      assert items == Auction.list_items()
    end
  end

  describe "get_items/1" do
    setup do
      {:ok, item1} = Repo.insert(%Item{title: "item 1"})
      {:ok, item2} = Repo.insert(%Item{title: "item 2"})
      %{items: [item1, item2]}
    end

    test "returns a single item based on id", %{items: items} do
      item = Enum.at(items, 1)
      assert item == Auction.get_item(item.id)
    end
  end
end
