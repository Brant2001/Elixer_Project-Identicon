defmodule Identicon do
  def name(input) do
    input
    |> hash_input
  end

  def hash_input(input) do
    :crypto.hash(:md5, input)
    |> :binary.bin_to_list()
  end
end