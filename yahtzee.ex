defmodule Yahtzee do
  def simulate_yahtzee(n_dice \\ 5, tries \\ 3) do
    dice = for _ <- 1..n_dice, do: :rand.uniform(6)

    dice =
      Enum.reduce(1..(tries - 1), dice, fn _i, dice ->
        if MapSet.new(dice) |> MapSet.size() > 1 do
          most_common = mode(dice)

          Enum.map(dice, fn x ->
            if x == most_common do
              x
            else
              :rand.uniform(6)
            end
          end)
        else
          dice
        end
      end)

    MapSet.new(dice) |> MapSet.size() == 1
  end

  defp mode(l) do
    pairs =
      Enum.reduce(l, %{}, fn el, acc ->
        case Map.fetch(acc, el) do
          {:ok, v} -> Map.put(acc, el, v + 1)
          _ -> Map.put(acc, el, 1)
        end
      end)
      |> Enum.sort_by(fn {_k, v} -> v end, :desc)

    case pairs do
      [{k, _v} | _tail] -> k
      _ -> nil
    end
  end
end

n = 1000000

n_wins =
  Enum.reduce(1..n, 0, fn _i, n_wins ->
    if Yahtzee.simulate_yahtzee() do
      n_wins + 1
    else
      n_wins
    end
  end)

IO.inspect("Percentage: #{n_wins / n}")
