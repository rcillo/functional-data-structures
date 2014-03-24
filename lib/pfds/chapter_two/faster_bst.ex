defmodule PFDS.FasterBinaryTree do
  def member(x, t) do
    member(x, t, nil)
  end

  def member(x, {l, y, r}, c) do
    if x < y do
      member(x, l, c)
    else
      member(x, r, y)
    end
  end

  def member(x, nil, c) do
    x == c
  end

  def add(x, t) do
    try do
      do_add(x, t, nil)
    rescue
      _ -> t
    end
  end

  def do_add(x, nil, c) do
    if x == c do
      raise "element already present"
    else
      {nil, x, nil}
    end
  end

  def do_add(x, t = {l, y, r}, c) do
    if x < y do
      {do_add(x, l, c), y, r}
    else
      {l, y, do_add(x, r, y)}
    end
  end
end
