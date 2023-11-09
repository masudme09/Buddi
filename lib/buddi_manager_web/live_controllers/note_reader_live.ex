defmodule BuddiManagerWeb.NoteReaderLive do
  use BuddiManagerWeb, :live_view

  def mount(
        %{"uid" => note_uid} = params,
        %{"user_token" => user_token, "_csrf_token" => _csrf_toket} = session,
        socket
      ) do
    IO.inspect(params: params, session: session, socket: socket)

    user = BuddiManager.Accounts.get_user_by_session_token(user_token)

    socket =
      socket
      |> assign(current_user: user)

    {:ok, socket}
  end

  def mount(params, session, socket) do
    IO.inspect(params: params, session: session, socket: socket)
    {:ok, socket}
  end

  def render(assigns, _params \\ %{}) do
    Phoenix.View.render(BuddiManagerWeb.NoteWebLiveView, "note_reader_live.html", assigns)
  end
end
