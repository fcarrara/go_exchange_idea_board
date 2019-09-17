defmodule GoExchangeIdeaBoardWeb.InputHelpers do
  @moduledoc """
  Conveniences for translating and building error messages.
  """

  use Phoenix.HTML

  def input(form, field, opts \\ []) do
    type = opts[:using] || Phoenix.HTML.Form.input_type(form, field)

    input_opts = [class: "form-control #{state_class(form, field)}"]
    label = content_tag(:strong, humanize(field), class: "text-muted d-block mb-2")
    input = input(type, form, field, input_opts)
    error = GoExchangeIdeaBoardWeb.ErrorHelpers.error_tag(form, field)

    if opts[:no_label], do: [input || ""], else: [label, input, error || ""]
  end

  defp state_class(form, field) do
    cond do
      !form.source.action -> ""
      form.errors[field] -> "is-invalid"
      true -> "is-valid"
    end
  end

  defp input(type, form, field, input_opts) do
    apply(Phoenix.HTML.Form, type, [form, field, input_opts])
  end
end
