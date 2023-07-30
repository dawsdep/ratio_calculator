# add state/options to run something everytime state is set
# ex: get_visual & get_state
# add ability to just return output once after running one command on the termninal
#   ex: ratio_calc h 20 w 20 => 100%
# left off... cant get args from "iex -S mix arg1 arg2" into System.argv

defmodule RatioCalc.Supervisor do
  use Application

  def start(_, _) do
    children = [RatioCalc]
    Supervisor.start_link(children, strategy: :one_for_one)
  end
end

defmodule RatioCalc do
  use Agent

  @default_dimensions %{h: 9, w: 16}

  def start_link(%{h: h, w: w}) do
    ratio = calc_ratio(h, w)
    Agent.start_link(fn -> %{h: h, w: w, ratio: ratio} end, name: __MODULE__)
  end
  def start_link(%{h: h}) do
    ratio = calc_ratio(h, @default_dimensions.w)
    Agent.start_link(fn -> %{h: h, w: @default_dimensions.w, ratio: ratio} end, name: __MODULE__)
  end
  def start_link(%{w: w}) do
    ratio = calc_ratio(@default_dimensions.h, w)
    Agent.start_link(fn -> %{h: @default_dimensions.h, w: w, ratio: ratio} end, name: __MODULE__)
  end
  def start_link(_) do
    IO.inspect(System.argv())
    ratio = calc_ratio(@default_dimensions.h, @default_dimensions.w)
    Agent.start_link(fn -> %{h: @default_dimensions.h, w: @default_dimensions.w, ratio: ratio} end, name: __MODULE__)
  end

  defp calc_ratio(h, w) do
    (h / w) * 100
  end

  defp get_all_state do
    Agent.get(__MODULE__, &(&1))
  end

  def set_dimensions(%{h: h, w: w}) do
    ratio = calc_ratio(h, w)
    Agent.update(__MODULE__, fn _ -> %{h: h, w: w, ratio: ratio} end)
  end
  def set_dimensions(%{h: h}) do
    %{w: w} = get_all_state()
    ratio = calc_ratio(h, w)
    Agent.update(__MODULE__, fn _ -> %{h: h, w: w, ratio: ratio} end)
  end
  def set_dimensions(%{w: w}) do
    %{h: h} = get_all_state()
    ratio = calc_ratio(h, w)
    Agent.update(__MODULE__, fn _ -> %{h: h, w: w, ratio: ratio} end)
  end

  def get_state(fields \\ nil) do
    state = get_all_state()
    case fields do
      nil -> state
      _ -> Map.take(state, fields)
    end
  end

  defp view_dimensions() do
    view_size = 20
    %{h: h, w: w, ratio: ratio} = get_all_state()
    if h > w do
      %{h: view_size, w: round(view_size / (ratio / 100))}
    else if w > h do
      %{h: round(view_size * (ratio / 100)), w: view_size}
    else
      %{h: view_size, w: view_size}
    end
    end
  end

  def get_visual() do
    %{h: h, w: w} = view_dimensions()
    h_char = "│"
    w_char = "─"
    w_multiplier = 2
    w_constant = div(w, 3)
    # just using a multiplier of 2 brings w & h close to each other in size
    # also using a constant a third of w brings w & h VERY close to each other in size
    w_value = (w * w_multiplier) + w_constant

    w_line = String.duplicate(w_char, w_value)

    IO.puts("┌" <> w_line <> "┐")
    Enum.each(1..h, fn _ ->
      IO.puts(h_char <> String.duplicate(" ", w_value) <> h_char)
    end)
    IO.puts("└" <> w_line <> "┘")
  end

end
