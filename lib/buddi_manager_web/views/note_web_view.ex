defmodule BuddiManagerWeb.NoteWebLiveView do
  use BuddiManagerWeb, :view

  def get_title(action) do
    case action do
      :create -> gettext("Create Note")
      :edit -> gettext("Edit Note")
      action -> action
    end
  end
end
