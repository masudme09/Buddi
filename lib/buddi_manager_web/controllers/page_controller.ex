defmodule BuddiManagerWeb.PageController do
  # import Plug.Conn
  use BuddiManagerWeb, :controller
  alias BuddiManager.Notes

  def index(conn, params) do
    # per page should be even number

    notes = Notes.list_notes()

    conn
    |> assign(:notes, notes)
    |> render("index.html")
  end
end
