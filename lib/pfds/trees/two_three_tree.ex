defmodule TwoThreeTree do
  def add(x, nil) do
    make_leaf(x)
  end

  def add(x, {[y], nil, 0}) do
    make_leaf([x, y])
  end

  def add(x, {[a, b], nil, 0}) do
    [min, med, max] = Enum.sort([x, a, b])
    {[med], [make_leaf(min), make_leaf(max)], 1}
  end

  def add(x, {items = [y], [a, b], d}) when x < y do
    a1 = add(x, a)

    if depth(a1) > depth(a) do
      {[a1_root], [a1_left, a1_right], _d} = a1
      {[a1_root, y], [a1_left, a1_right, b], d}
    else
      {items, [a1, b], d}
    end
  end

  def add(x, {items = [y], [a, b], d}) when x > y do
    b1 = add(x, b)

    if depth(b1) > depth(b) do
      {[b1_root], [b1_left, b1_right], _d} = b1
      {[y, b1_root], [a, b1_left, b1_right], d}
    else
      {items, [a, b1], d}
    end
  end

  def add(x, {items = [y, z], [a, b, c], d}) when x < y do
    a1 = add(x, a)

    if depth(a1) > depth(a) do
      {[y], [a1, {[z], [b, c], d}], d + 1}
    else
      {items, [a1, b, c], d}
    end
  end

  def add(x, {items = [y, z], [a, b, c], d}) when x < z do
    b1 = add(x, b)

    if depth(b1) > depth(b) do
      {[b1_root], [l_b1, r_b1], depth_b1} = b1
      l = {[y], [a, l_b1], d}
      r = {[z], [r_b1, c], d}
      {[b1_root], [l, r], d + 1}
    else
      {items, [a, b1, c], d}
    end
  end

  def add(x, {items = [y, z], [a, b, c], d}) when x > z do
    c1 = add(x, c)

    if depth(c1) > depth(c) do
      {[z], [{[y], [a, b], d}, c1], d + 1}
    else
      {items, [a, b, c1], d}
    end
  end

  defp make_leaf(items) when is_list(items) do
    {Enum.sort(items), nil, 0}
  end

  defp make_leaf(item) do
    make_leaf([item])
  end

  defp depth({_items, _children, d}), do: d
end
