defmodule BuddiManagerWeb.Router do
  alias BuddiManagerWeb.DashboardController
  use BuddiManagerWeb, :router

  import BuddiManagerWeb.UserAuth
  import Phoenix.LiveView.Router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:put_root_layout, {BuddiManagerWeb.LayoutView, :root})
    plug(:fetch_live_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
    plug(:fetch_current_user)
    plug(Plug.CSRFProtection)
  end

  scope "/" do
    pipe_through(:browser)
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through(:browser)

      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end

  ## Authentication routes

  scope "/", BuddiManagerWeb do
    pipe_through([:browser, :redirect_if_user_is_authenticated])

    get("/users/register", UserRegistrationController, :new)
    post("/users/register", UserRegistrationController, :create)
    get("/users/log_in", UserSessionController, :new)
    post("/users/log_in", UserSessionController, :create)
    get("/users/reset_password", UserResetPasswordController, :new)
    post("/users/reset_password", UserResetPasswordController, :create)
    get("/users/reset_password/:token", UserResetPasswordController, :edit)
    put("/users/reset_password/:token", UserResetPasswordController, :update)
  end

  scope "/", BuddiManagerWeb do
    pipe_through([
      :browser,
      :require_authenticated_user
    ])

    get("/users/settings", UserSettingsController, :edit)
    put("/users/settings", UserSettingsController, :update)
    get("/users/settings/confirm_email/:token", UserSettingsController, :confirm_email)
    # BuddiManager routes
    resources("/note", NoteController)
    live("/", VisualBoardLive)
  end

  # live routes
  scope "/live", BuddiManagerWeb do
    pipe_through([:browser, :require_authenticated_user])
    live("/note", NoteWebLive)
    # live("/note/:id", NoteWebLive, :edit)

    live("/visual_board", VisualBoardLive)
  end

  scope "/", BuddiManagerWeb do
    pipe_through([:browser])

    delete("/users/log_out", UserSessionController, :delete)
    get("/users/confirm", UserConfirmationController, :new)
    post("/users/confirm", UserConfirmationController, :create)
    get("/users/confirm/:token", UserConfirmationController, :edit)
    post("/users/confirm/:token", UserConfirmationController, :update)
  end
end
