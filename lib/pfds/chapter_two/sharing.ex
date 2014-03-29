defmodule PFDS.Sharing do
  def complete(x, d) do
    do_complete(x, d)
  end

  defp do_complete(x, 1) do
    {nil, x, nil}
  end

  defp do_complete(x, d) do
    s = do_complete(x, d - 1)
    {s, x, s}
  end
end
