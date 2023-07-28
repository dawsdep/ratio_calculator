defmodule RatioCalc do
  @default_dimensions %{h: 9, w: 16}
  def start(%{h: h, w: w}) do
    Agent.start_link(fn -> %{h: h, w: w} end, name: __MODULE__)
    calc_ratio()
  end
  def start(%{h: h}) do
    Agent.start_link(fn -> %{h: h, w: @default_dimensions.w} end, name: __MODULE__)
    calc_ratio()
  end
  def start(%{w: w}) do
    Agent.start_link(fn -> %{h: @default_dimensions.h, w: w} end, name: __MODULE__)
    calc_ratio()
  end
  def start(_) do
    Agent.start_link(fn -> @default_dimensions end, name: __MODULE__)
    calc_ratio()
  end
  def start() do
    Agent.start_link(fn -> @default_dimensions end, name: __MODULE__)
    calc_ratio()
  end

  defp calc_ratio() do
    %{h: h, w: w} = get_all_state()
    ratio = (h / w) * 100
    set_state(%{ratio: ratio})
  end

  defp get_all_state do
    Agent.get(__MODULE__, &(&1))
  end

  defp set_state(%{h: h, w: w}) do
    Agent.update(__MODULE__, fn _ -> %{h: h, w: w} end)
    calc_ratio()
  end
  defp set_state(%{h: h}) do
    %{w: w} = get_all_state()
    Agent.update(__MODULE__, fn _ -> %{h: h, w: w} end)
    calc_ratio()
  end
  defp set_state(%{w: w}) do
    %{h: h} = get_all_state()
    Agent.update(__MODULE__, fn _ -> %{h: h, w: w} end)
    calc_ratio()
  end
  defp set_state(%{ratio: ratio}) do
    state = get_all_state()
    merged_state = Map.merge(%{ratio: ratio}, state, fn _, new, _ -> new end)
    Agent.update(__MODULE__, fn _ -> merged_state end)
  end

  def set_dimensions(%{h: h, w: w}) do
    set_state(%{h: h, w: w})
  end
  def set_dimensions(%{h: h}) do
    set_state(%{h: h})
  end
  def set_dimensions(%{w: w}) do
    set_state(%{w: w})
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
