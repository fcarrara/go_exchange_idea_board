defmodule GoExchangeIdeaBoardWeb.RetroSessionView do
  use GoExchangeIdeaBoardWeb, :view

  alias GoExchangeIdeaBoardWeb.{NoteLive, RetroSessionLive}

  def get_note_value(changeset) do
    {:ok, value} = Map.fetch(changeset.data, :content)

    if value == nil, do: "", else: value
  end

  def parse_date(date) do
    Timex.format!(date, "{D}-" <> Timex.month_shortname(date.month) <> "-{YYYY}")

    # Timex.format!(date, Timex.day_shortname(Date.day_of_week(date)) <> " {D}-" <> Timex.month_shortname(date.month) <> "-{YYYY}")
  end
end
