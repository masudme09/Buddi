defmodule BuddiManagerWeb.VisualBoardLive do
  use BuddiManagerWeb, :live_view
  alias BuddiManager.Notes

  def mount(params, %{"user_token" => user_token} = _session, socket) do
    user = BuddiManager.Accounts.get_user_by_session_token(user_token)

    notes = Notes.list_notes()

    socket =
      socket
      |> assign(notes: notes)
      |> assign(current_user: user)

    {:ok, socket}
  end

  def render(assigns, _params \\ %{}) do
    Phoenix.View.render(BuddiManagerWeb.VisualBoardLiveView, "visual_board_live.html", assigns)
  end
end
