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
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end

  @doc """
    Takes the image and saves it to the local device
  ## Examples

  """
  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  @doc """
    Takes the pixel map and builds a random image that coralates to a specific string
  ## Examples

  """
  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :edg.create(250, 250)
    fill = :edg.color(color)

    Enum.each(pixel_map, fn {start, stop} ->
      :edg.filledRectangle(image, start, stop, fill)
    end)

    :edg.render(image)
  end

  @doc """
    Takes the filtered grid and creates a pixel map
  ## Examples

  """
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map =
      Enum.map(grid, fn {_code, index} ->
        horizontal = rem(index, 5) * 50
        vertical = div(index, 5) * 50

        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 50, vertical + 50}

        {top_left, bottom_right}
      end)

    %Identicon.Image{image | pixel_map: pixel_map}
  end

  @doc """
    Takes the grid and filters out the odd numbers
  ## Examples

  """
  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid =
      Enum.filter(grid, fn {code, _index} ->
        rem(code, 2) == 0
      end)

    %Identicon.Image{image | grid: grid}
  end

  @doc """
    Takes the list of mirrored numbers and creates a grid
  ## Examples

  """
  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
  end

  @doc """
    Takes a list of numbers and mirrors it taking 1, 2, 3 and turning it into 1, 2, 3, 2, 1
  ## Examples

  """
  def mirror_row(row) do
    [first, second | _tail] = row
    row ++ [second, first]
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
