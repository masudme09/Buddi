defmodule BuddiManagerWeb.NoteWebLive do
  use BuddiManagerWeb, :live_view
  # import BuddiManagerWeb.LiveHelpers
  # alias BuddiManager.Notes
  alias BuddiManager.Notes.Note
  alias BuddiManager.Repo

  @doc """
  This module is reponsible for creating and updating notes
  FIXME: Need to modify the liveview logic, by initializing with initial struct and later on update and validate based on that
  """
  def mount(params, %{"user_token" => user_token} = _session, socket) do
    user = BuddiManager.Accounts.get_user_by_session_token(user_token)
    changeset = init_changeset(params, user)

    socket =
      socket
      |> assign(current_user: user)
      |> assign(changeset: changeset)
      |> assign(preview_content: "")
      |> assign(preview_label: "")

    {:ok, socket}
  end

  def render(assigns, _params \\ %{}) do
    Phoenix.View.render(BuddiManagerWeb.NoteWebLiveView, "index.html", assigns)
  end

  def handle_event("form.note.change", params, socket) do
    %{
      "note" => %{"content" => content, "label" => label} = note_params
    } = params

    %{assigns: %{changeset: changeset}} = socket

    changeset =
      Map.get(changeset, :data)
      |> Note.changeset(note_params)

    content =
      content
      |> Earmark.as_html!()
      |> Phoenix.HTML.raw()

    socket =
      socket
      |> assign(preview_content: content)
      |> assign(preview_label: label)
      |> assign(changeset: changeset)

    {:noreply, socket}
  end

  def handle_event("form.note.submit", params, socket) do
    %{
      "note" => %{"content" => content, "label" => label} = note_params
    } = params

    %{assigns: %{changeset: changeset}} = socket

    Map.get(changeset, :data)
    |> Repo.preload([:user])
    |> Note.changeset(note_params)
    |> Repo.insert_or_update()
    |> case do
      {:ok, _} ->
        {:noreply,
         socket
         |> put_flash(:info, "Created or Updated")
         |> redirect(to: Routes.dashboard_path(BuddiManagerWeb.Endpoint, :index))}

      {:error, changeset} ->
        socket =
          socket
          |> put_flash(:info, "Something went wrong")
          |> assign(preview_content: content)
          |> assign(preview_label: label)
          |> assign(changeset: changeset)

        {:noreply, socket}
    end
  end

  defp init_changeset(params, user) do
    params["id"]
    |> case do
      nil ->
        %Note{
          user: user,
          content: ""
        }
        |> Note.changeset(%{})

      note_id ->
        Repo.get!(Note, note_id)
        |> Note.changeset()
    end
  end
end
