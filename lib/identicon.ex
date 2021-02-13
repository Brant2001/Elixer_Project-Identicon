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
    Returns a list of numbers from the hashing function in the form of a struct

  ## Examples

  """
  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end
end
