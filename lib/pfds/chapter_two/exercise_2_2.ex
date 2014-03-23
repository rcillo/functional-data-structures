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
end
