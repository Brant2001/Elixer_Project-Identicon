defmodule Identicon do
  @moduledoc """
    Generates a custom Identicon based on a string input
  """

  @doc """
    Pulls in other functions and uses them in conjuntion of one another


  ## Examples

  """
  def main(input) do
    input
    |> hash_input
    |> pick_color
  end

  @doc """
    Pulls in a list of hashed numbers and returns the first three values

  ## Examples

  """
  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    %Identicon.Image{image | color: {r, g, b}}
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
