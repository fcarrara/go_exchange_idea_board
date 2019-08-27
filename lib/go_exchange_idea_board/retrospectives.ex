defmodule GoExchangeIdeaBoard.Retrospectives do
  @moduledoc """
  The Retrospectives context.
  """

  import Ecto.Query, warn: false
  alias GoExchangeIdeaBoard.Repo

  alias GoExchangeIdeaBoard.Retrospectives.RetroFormat

  @doc """
  Returns the list of retro_formats.

  ## Examples

      iex> list_retro_formats()
      [%RetroFormat{}, ...]

  """
  def list_retro_formats do
    Repo.all(RetroFormat)
  end

  @doc """
  Gets a single retro_format.

  Raises `Ecto.NoResultsError` if the Retro format does not exist.

  ## Examples

      iex> get_retro_format!(123)
      %RetroFormat{}

      iex> get_retro_format!(456)
      ** (Ecto.NoResultsError)

  """
  def get_retro_format!(id), do: Repo.get!(RetroFormat, id)

  @doc """
  Creates a retro_format.

  ## Examples

      iex> create_retro_format(%{field: value})
      {:ok, %RetroFormat{}}

      iex> create_retro_format(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_retro_format(attrs \\ %{}) do
    %RetroFormat{}
    |> RetroFormat.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a retro_format.

  ## Examples

      iex> update_retro_format(retro_format, %{field: new_value})
      {:ok, %RetroFormat{}}

      iex> update_retro_format(retro_format, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_retro_format(%RetroFormat{} = retro_format, attrs) do
    retro_format
    |> RetroFormat.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a RetroFormat.

  ## Examples

      iex> delete_retro_format(retro_format)
      {:ok, %RetroFormat{}}

      iex> delete_retro_format(retro_format)
      {:error, %Ecto.Changeset{}}

  """
  def delete_retro_format(%RetroFormat{} = retro_format) do
    Repo.delete(retro_format)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking retro_format changes.

  ## Examples

      iex> change_retro_format(retro_format)
      %Ecto.Changeset{source: %RetroFormat{}}

  """
  def change_retro_format(%RetroFormat{} = retro_format) do
    RetroFormat.changeset(retro_format, %{})
  end

  alias GoExchangeIdeaBoard.Retrospectives.RetroFormatColumn

  @doc """
  Returns the list of retro_format_columns.

  ## Examples

      iex> list_retro_format_columns()
      [%RetroFormatColumn{}, ...]

  """
  def list_retro_format_columns do
    Repo.all(RetroFormatColumn)
  end

  @doc """
  Gets a single retro_format_column.

  Raises `Ecto.NoResultsError` if the Retro format column does not exist.

  ## Examples

      iex> get_retro_format_column!(123)
      %RetroFormatColumn{}

      iex> get_retro_format_column!(456)
      ** (Ecto.NoResultsError)

  """
  def get_retro_format_column!(id), do: Repo.get!(RetroFormatColumn, id)

  @doc """
  Creates a retro_format_column.

  ## Examples

      iex> create_retro_format_column(%{field: value})
      {:ok, %RetroFormatColumn{}}

      iex> create_retro_format_column(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_retro_format_column(attrs \\ %{}) do
    %RetroFormatColumn{}
    |> RetroFormatColumn.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a retro_format_column.

  ## Examples

      iex> update_retro_format_column(retro_format_column, %{field: new_value})
      {:ok, %RetroFormatColumn{}}

      iex> update_retro_format_column(retro_format_column, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_retro_format_column(%RetroFormatColumn{} = retro_format_column, attrs) do
    retro_format_column
    |> RetroFormatColumn.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a RetroFormatColumn.

  ## Examples

      iex> delete_retro_format_column(retro_format_column)
      {:ok, %RetroFormatColumn{}}

      iex> delete_retro_format_column(retro_format_column)
      {:error, %Ecto.Changeset{}}

  """
  def delete_retro_format_column(%RetroFormatColumn{} = retro_format_column) do
    Repo.delete(retro_format_column)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking retro_format_column changes.

  ## Examples

      iex> change_retro_format_column(retro_format_column)
      %Ecto.Changeset{source: %RetroFormatColumn{}}

  """
  def change_retro_format_column(%RetroFormatColumn{} = retro_format_column) do
    RetroFormatColumn.changeset(retro_format_column, %{})
  end

  alias GoExchangeIdeaBoard.Retrospectives.RetroSession

  @doc """
  Returns the list of retro_sessions.

  ## Examples

      iex> list_retro_sessions()
      [%RetroSession{}, ...]

  """
  def list_retro_sessions do
    Repo.all(RetroSession)
  end

  @doc """
  Gets a single retro_session.

  Raises `Ecto.NoResultsError` if the Retro session does not exist.

  ## Examples

      iex> get_retro_session!(123)
      %RetroSession{}

      iex> get_retro_session!(456)
      ** (Ecto.NoResultsError)

  """
  def get_retro_session!(id), do: Repo.get!(RetroSession, id)

  @doc """
  Creates a retro_session.

  ## Examples

      iex> create_retro_session(%{field: value})
      {:ok, %RetroSession{}}

      iex> create_retro_session(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_retro_session(attrs \\ %{}) do
    %RetroSession{}
    |> RetroSession.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a retro_session.

  ## Examples

      iex> update_retro_session(retro_session, %{field: new_value})
      {:ok, %RetroSession{}}

      iex> update_retro_session(retro_session, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_retro_session(%RetroSession{} = retro_session, attrs) do
    retro_session
    |> RetroSession.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a RetroSession.

  ## Examples

      iex> delete_retro_session(retro_session)
      {:ok, %RetroSession{}}

      iex> delete_retro_session(retro_session)
      {:error, %Ecto.Changeset{}}

  """
  def delete_retro_session(%RetroSession{} = retro_session) do
    Repo.delete(retro_session)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking retro_session changes.

  ## Examples

      iex> change_retro_session(retro_session)
      %Ecto.Changeset{source: %RetroSession{}}

  """
  def change_retro_session(%RetroSession{} = retro_session, attrs \\ %{}) do
    RetroSession.changeset(retro_session, attrs)
  end

  alias GoExchangeIdeaBoard.Retrospectives.Note

  @doc """
  Returns the list of notes.

  ## Examples

      iex> list_notes()
      [%Note{}, ...]

  """
  def list_notes do
    Repo.all(Note)
  end

  @doc """
  Gets a single note.

  Raises `Ecto.NoResultsError` if the Note does not exist.

  ## Examples

      iex> get_note!(123)
      %Note{}

      iex> get_note!(456)
      ** (Ecto.NoResultsError)

  """
  def get_note!(id), do: Repo.get!(Note, id)

  @doc """
  Creates a note.

  ## Examples

      iex> create_note(%{field: value})
      {:ok, %Note{}}

      iex> create_note(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_note(attrs \\ %{}) do
    %Note{}
    |> Note.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a note.

  ## Examples

      iex> update_note(note, %{field: new_value})
      {:ok, %Note{}}

      iex> update_note(note, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_note(%Note{} = note, attrs) do
    note
    |> Note.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Note.

  ## Examples

      iex> delete_note(note)
      {:ok, %Note{}}

      iex> delete_note(note)
      {:error, %Ecto.Changeset{}}

  """
  def delete_note(%Note{} = note) do
    Repo.delete(note)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking note changes.

  ## Examples

      iex> change_note(note)
      %Ecto.Changeset{source: %Note{}}

  """
  def change_note(%Note{} = note) do
    Note.changeset(note, %{})
  end

  alias GoExchangeIdeaBoard.Retrospectives.ActionItem

  @doc """
  Returns the list of action_items.

  ## Examples

      iex> list_action_items()
      [%ActionItem{}, ...]

  """
  def list_action_items do
    Repo.all(ActionItem)
  end

  @doc """
  Gets a single action_item.

  Raises `Ecto.NoResultsError` if the Action item does not exist.

  ## Examples

      iex> get_action_item!(123)
      %ActionItem{}

      iex> get_action_item!(456)
      ** (Ecto.NoResultsError)

  """
  def get_action_item!(id), do: Repo.get!(ActionItem, id)

  @doc """
  Creates a action_item.

  ## Examples

      iex> create_action_item(%{field: value})
      {:ok, %ActionItem{}}

      iex> create_action_item(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_action_item(attrs \\ %{}) do
    %ActionItem{}
    |> ActionItem.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a action_item.

  ## Examples

      iex> update_action_item(action_item, %{field: new_value})
      {:ok, %ActionItem{}}

      iex> update_action_item(action_item, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_action_item(%ActionItem{} = action_item, attrs) do
    action_item
    |> ActionItem.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ActionItem.

  ## Examples

      iex> delete_action_item(action_item)
      {:ok, %ActionItem{}}

      iex> delete_action_item(action_item)
      {:error, %Ecto.Changeset{}}

  """
  def delete_action_item(%ActionItem{} = action_item) do
    Repo.delete(action_item)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking action_item changes.

  ## Examples

      iex> change_action_item(action_item)
      %Ecto.Changeset{source: %ActionItem{}}

  """
  def change_action_item(%ActionItem{} = action_item) do
    ActionItem.changeset(action_item, %{})
  end
end
