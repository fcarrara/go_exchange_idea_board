defmodule GoExchangeIdeaBoardWeb.RetroSessionView do
  use GoExchangeIdeaBoardWeb, :view

  def get_note_value(changeset) do
    {:ok, value} = Map.fetch(changeset.data, :content)

    if value == nil, do: "", else: value
  end

  def parse_date(date) do
    Timex.format!(date, "{D}-" <> Timex.month_shortname(date.month) <> "-{YYYY}")

    # Timex.format!(date, Timex.day_shortname(Date.day_of_week(date)) <> " {D}-" <> Timex.month_shortname(date.month) <> "-{YYYY}")
  end

  def get_grouped_notes(notes) do
    notes
    |> Enum.group_by(& &1.group_id)
  end

  def get_total_votes(notes) do
    notes
    |> Enum.reduce(0, fn note, acc -> note.votes + acc end)
  end
end
