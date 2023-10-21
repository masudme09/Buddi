defmodule BuddiManagerWeb.DashboardController do
  use BuddiManagerWeb, :controller
  alias BuddiManager.Notes

  def index(conn, params) do
    notes = Notes.list_notes()

    conn
    |> assign(:notes, notes)
    |> render("index.html")
  end
end
