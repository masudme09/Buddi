defmodule BuddiManagerWeb.CoreComponents do
  use Phoenix.Component
  import BuddiManagerWeb.Gettext
  # import BuddiManager.ViewHelpers
  import Phoenix.HTML.Link
  alias BuddiManagerWeb.Router.Helpers, as: Routes

  attr(:current_user, :any, default: nil)

  def top_bar(assigns) do
    ~H"""
    <nav
      class="navbar main navbar-expand-lg navbar-light bg-primary sticky-top mb-3"
      style="height: 48px;"
    >
      <div class="d-flex justify-content-between align-items-center mx-5" style="width: 100%;">
        <a class="navbar-brand" href="#">
          <label class="label logo" style="font-size: 36px;">Buddi</label>
        </a>
        <%= if @current_user do %>
          <div class="d-flex align-items-center">
            <%= link("account_circle",
              to: Routes.user_settings_path(BuddiManagerWeb.Endpoint, :edit),
              method: :get,
              class: "nav-link material-icons md-36",
              title: "Profile Settings"
            ) %>
            <%= link("Logout",
              to: Routes.user_session_path(BuddiManagerWeb.Endpoint, :delete),
              method: :delete,
              class: "nav-link text-light ms-2 md-18",
              title: "Logout"
            ) %>
          </div>
        <% end %>
      </div>
    </nav>
    """
  end

  def footer(assigns) do
    ~H"""
    <footer class="footer bg-primary navbar fixed-bottom d-flex justify-content-center align-items-center">
      <label class="label text-white">@Copyright MIT</label>
    </footer>
    """
  end

  def sidebar(assigns) do
    ~H"""
    <div>
      <a
        class="btn d-flex flex-row justify-content-start align-items-center px-0"
        href={Routes.live_path(BuddiManagerWeb.Endpoint, BuddiManagerWeb.VisualBoardLive)}
      >
        <span class="material-icons md-24"> dashboard </span>
        <label class="md-14 mx-1"> Home </label>
      </a>

      <a
        class="btn d-flex flex-row justify-content-start align-items-center px-0"
        href={Routes.live_path(BuddiManagerWeb.Endpoint, BuddiManagerWeb.NoteWebLive)}
      >
        <span class="material-icons md-24"> description </span>
        <label class="md-14 mx-1"> Add Text Note </label>
      </a>

      <button class="btn d-flex flex-row justify-content-start align-items-center px-0">
        <span class="material-icons md-24"> mic </span>
        <label class="md-14 mx-1"> Add voice Note </label>
      </button>

      <button class="btn d-flex flex-row justify-content-start align-items-center px-0">
        <span class="material-icons md-24"> image </span>
        <label class="md-14 mx-1 ms-1">Add img Note</label>
      </button>

      <div class="mt-5 users_list">
        <button class="btn d-flex flex-row justify-content-start align-items-center px-0">
          <span class="material-icons md-24"> people </span>
          <label class="md-14 mx-1"> Users </label>
        </button>
      </div>

      <div class="d-flex flex-column justify-content-start">
        <.show_users />
      </div>
    </div>
    """
  end

  def show_users(assigns) do
    ~H"""
    <div>
      <%= for user <- BuddiManager.Accounts.list_users(4) do %>
        <.user_display user={user} />
      <% end %>
    </div>
    """
  end

  attr(:user, :any)

  def user_display(assigns) do
    ~H"""
    <div class="d-flex flex-column border my-1 bg-light bg-gradient rounded" style="width: 150px;">
      <div class="d-flex flex-row mt-1 mx-1">
        <span>
          <i class="material-icons md-14">account_box</i>
        </span>
        <label class="ms-2 md-14"><%= @user.name %></label>
      </div>
      <div class="d-flex justify-content-end mx-2 my-1">
        <button
          class="btn btn-primary btn-sm ms-1 d-flex flex-row justify-content-center p-0 md-12"
          style="width: 75px;"
        >
          <%= gettext("Connect") %>
        </button>
      </div>
    </div>
    """
  end
end
