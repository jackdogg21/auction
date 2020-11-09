defmodule AuctionWeb.ItemControllerTest do
  use AuctionWeb.ConnCase

  test "GET /", %{conn: conn} do
    {:ok, _item} = Auction.insert_item(%{title: "test item"})
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "test item"
  end

  describe "POST /items" do
    test "with valid params, redirects to the new item", %{conn: conn} do
      conn = post conn, "/items", %{item: %{title: "test item"}}
      assert redirected_to(conn) =~ ~r|/items/\d+|
    end

    test "with valid params, creates a new item", %{conn: conn} do
      before_count = Enum.count(Auction.list_items())
      post conn, "/items", %{item: %{title: "test item"}}
      assert Enum.count(Auction.list_items()) == before_count + 1
    end

    test "with invalid params, does not create a new item", %{conn: conn} do
      before_count = Enum.count(Auction.list_items())
      post conn, "items", %{item: %{bad_param: "test item"}}
      assert Enum.count(Auction.list_items()) == before_count
    end

    test "with invalid params, show then new item form", %{conn: conn} do
      conn = post conn, "items", %{item: %{bad_param: "test item"}}
      assert html_response(conn, 200) =~ "<h1>New Item</h1>"
    end
  end
end
