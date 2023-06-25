defmodule BuddiManagerWeb.DashboardComponents do
  use Phoenix.Component
  import BuddiManagerWeb.Gettext
  import BuddiManager.ViewHelpers

  @doc """
  This module will hold phoenix static components for dashboard
  """
  attr(:note, :any)
  attr(:note_delete_path, :string)
  attr(:note_show_path, :string)

  def note_card(assigns) do
    ~H"""
    <div class="card me-2 p-0" style="width: 16vw; height: 28vh;">
      <h6 class="card_title bg-primary text-white text-center">
        <%= if @note.label, do: @note.label, else: gettext("No title") %>
      </h6>

      <div class="card_body mx-2" style="height: 23vh; max-height: 23vh; overflow-y: auto">
        <p class="card-text">
          <%= note_visualize(@note) %>
        </p>
      </div>

      <p class="mx-2 my-1 md-12 text-secondary"><%= "Created by: " <> @note.created_by %></p>

      <div class="card-footer container align-items-center d-flex" style="height: 2rem">
        <div class="col-6 d-flex flex-row justify-content-start">
          <a
            class="btn me-1 p-0 d-flex flex-row justify-content-start"
            data-csrf={Plug.CSRFProtection.get_csrf_token()}
            data-method="delete"
            data-to={@note_delete_path}
            data-confirm="Are you sure?"
            title={gettext("Delete Note")}
          >
            <span class="material-icons md-18">
              highlight_off
            </span>
          </a>

          <button
            class="btn me-1 p-0 d-flex flex-row justify-content-start"
            data-method="get"
            data-to={@note_show_path}
            title={gettext("Full Screen")}
          >
            <span class="material-icons md-18">
              aspect_ratio
            </span>
          </button>
        </div>

        <% container_id = gen_dom_id() %>

        <div class="col-6 d-flex flex-row justify-content-end" id={container_id} phx-update="ignore">
          <% toggle_id = gen_dom_id() %>
          <% data_bs_parent = gen_dom_id() %>

          <button
            class="btn me-1 p-0 d-flex flex-row justify-content-start"
            title={gettext("Download note")}
            data-bs-toggle="collapse"
            data-bs-target={"#" <> toggle_id}
            aria-expanded="false"
            aria-controls="optionsCollapse"
            data-bs-parent={"#" <> data_bs_parent}
          >
            <span class="material-icons md-18">
              download_for_offline
            </span>
          </button>

          <button
            class="btn me-1 p-0 d-flex flex-row justify-content-start"
            title={gettext("Share note")}
          >
            <span class="material-icons md-18">
              share
            </span>
          </button>
        </div>

        <div
          class="collapse"
          id={toggle_id}
          data-bs-parent={"#" <> data_bs_parent}
          style="z-index: 100;"
        >
          <button type="button" class="btn btn-secondary">Option 1</button>
          <button type="button" class="btn btn-secondary">Option 2</button>
          <button type="button" class="btn btn-secondary">Option 3</button>
        </div>
      </div>
    </div>
    """
  end
end
