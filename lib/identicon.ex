defmodule Identicon do
  @moduledoc """
    Generates a custom Identicon based on a string input
  """

  @doc """


  ## Examples

  """
  def name(input) do
    input
    |> hash_input
  end

  @doc """


  ## Examples

  """
  def hash_input(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list()
  end
end
