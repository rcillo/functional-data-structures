defmodule TwoThreeTree do
  def add(x, nil) do
    {[x], nil, 0}
  end

  def add(x, {[y], nil, 0}) do
    if x > y do
      {[y, x], nil, 0}
    else
      {[x, y], nil, 0}
    end
  end

  def add(x, {[a, b], nil, 0}) do
    [min, med, max] = Enum.sort([x, a, b])
    {[med], [add(min, nil), add(max, nil)], 1}
  end

  def add(x, {items = [h], subs = [a, b], depth}) do
    if x > h do
      b1 = add(x, b)
      {_, _, depth_b} = b
      {_, _, depth_b1} = b1

      if depth_b1 > depth_b do
        {[b1_root], [b1_left, b1_right], _d} = b1
        {[h, b1_root], [a, b1_left, b1_right], depth}
      else
        {items, [a, b1], depth}
      end
    else
      a1 = add(x, a)
      {_, _, depth_a} = a
      {_, _, depth_a1} = a1

      if depth_a1 > depth_a do
        {[a1_root], [a1_left, a1_right], _d} = a1
        {[a1_root, h], [a1_left, a1_right, b], depth}
      else
        {items, [a1, b], depth}
      end
    end
  end

  def add(x, {items = [y, z], subs = [a, b, c], depth}) do
    if x < y do
      a1 = add(x, a)
      {_, _, depth_a} = a
      {_, _, depth_a1} = a1

      if depth_a1 > depth_a do
        {[y], [a1, {[z], [b, c], depth}], depth + 1}
      else
        {items, [a1, b, c], depth}
      end
    else
      if x < z do
        b1 = add(x, b)
        {_, _, depth_b} = b
        {_, _, depth_b1} = b1
        if depth_b1 > depth_b do
          {[b1_root], [l_b1, r_b1], depth_b1} = b1
          l = {[y], [a, l_b1], depth}
          r = {[z], [r_b1, c], depth}
          {[b1_root], [l, r], depth + 1}
        else
          {items, [a, b1, c], depth}
        end
      else
        c1 = add(x, c)
        {_, _, depth_c} = c
        {_, _, depth_c1} = c1
        if depth_c1 > depth_c do
          {[z], [{[y], [a, b], depth}, c1], depth + 1}
        else
          {items, [a, b, add(x, c)], depth}
        end
      end
    end
  end
end
