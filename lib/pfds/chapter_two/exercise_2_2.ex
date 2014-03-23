defmodule PFDS.FasterBinaryTree do
  def member(x, t) do
    member(x, t, nil)
  end

  def member(x, {l, y, r}, c) do
    if x <= y do
      member(x, l, y)
    else
      member(x, r, c)
    end
  end

  def member(x, nil, c) do
    x == c
  end
end
