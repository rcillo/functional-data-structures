defmodule TwoThreeTree do
  @moduledoc """
  A balanced 2-3-tree

  A tree implementation that has guaranteed logarithmic time
  for both search and insert. It does not degenerate like an
  unbalaced binary tree.

  Trees are represented by tuples:

  `{ a_list_of_keys, a_list_of_sub_trees, tree_height}`

  - `a_list_of_keys` may contain one or two elements `[y]` or `[y, z]`, where `y` < `z`
  - `a_list_of_sub_trees` may contain zero or three elements, `[a, b, c]` where
     every element in `a` are smaller than `y`, every element in `b` are bigger
     `y` and smaller than `z` and elements in `c` are bigger than `z`.
  - `tree_height` is 0 for leaf nodes.

  An empty tree is represented by `nil`. This way we do not spare space.
  """

  def member(x, {items, subs, _d}) do
    do_member(x, items, subs)
  end

  defp do_member(x, [y | _items], _subs) when x == y do
    true
  end

  defp do_member(x, [y | items], [a | subs]) do
    if x < y do
      member(x, a)
    else
      do_member(x, items, subs)
    end
  end

  defp do_member(x, [], [a]) do
    member(x, a)
  end

  defp do_member(x, items, nil) do
    Enum.member?(items, x)
  end

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
      {[b1_root], [l_b1, r_b1], _d} = b1
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
