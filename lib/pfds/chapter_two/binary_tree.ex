defmodule PFDS.BinaryTree do
  def add(x, {l, y, r}) when x >= y do
    {l, y, add(x, r)}
  end

  def add(x, {l, y, r}) when x < y do
    {add(x, l), y, r}
  end

  def add(x, nil) do
    {nil, x, nil}
  end

  def member(x, {_l, y, r}) when x > y do
    member(x, r)
  end

  def member(x, {l, y, _r}) when x < y do
    member(x, l)
  end

  def member(_x, nil) do
    false
  end

  def member(x, {_, y, _}) when x == y do
    true
  end
end
