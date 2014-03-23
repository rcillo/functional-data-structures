# “Exercise 2.1 Write a function suffixes of type α list → α list list that takes
# a list xs and returns a list of all the suffixes of xs in decreasing order of
# length. For example, suffixes [1,2,3,4] = [[1,2,3,4], [2,3,4], [3,4], [4], []]
#
# Show that the resulting list of suffixes can be generated in O(n) time and represented in O(n) space.”
defmodule PFDS.List do
  def suffixes(list) do
    do_suffixes(list, [list]) |> Enum.reverse
  end

  defp do_suffixes([], suffixes_list), do: suffixes_list

  defp do_suffixes([h | t], suffixes_list) do
    do_suffixes(t, [t | suffixes_list])
  end
end
