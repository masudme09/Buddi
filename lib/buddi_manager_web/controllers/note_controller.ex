defmodule BuddiManagerWeb.NoteController do
  use BuddiManagerWeb, :controller

  alias BuddiManager.Notes
  alias BuddiManager.Notes.Note

  def edit(conn, %{"id" => id}) do
    conn
    |> redirect(
      to: Routes.live_path(BuddiManagerWeb.Endpoint, BuddiManagerWeb.NoteWebLive, note_id: id)
    )
  end

  def show(conn, %{"id" => id}) do
    note = Notes.get_note!(id)

    conn
    |> render("show.html", note: note)
  end

  def delete(conn, %{"id" => id}) do
    note = Notes.get_note!(id)

    with {:ok, %Note{}} <- Notes.delete_note(note) do
      conn
      |> put_flash(:deleted, note.label)
      |> redirect(to: Routes.dashboard_path(conn, :index))
    end
  end
end
