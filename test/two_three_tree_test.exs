defmodule TwoThreeTreeTest do
  use ExUnit.Case
  alias TwoThreeTree, as: Tree

  test "add new leaf" do
    assert {[1], nil, 0} == Tree.add(1, nil)
  end

  test "add item to an existing leaf node with enough slots" do
    non_full_leaf = Tree.add(1, nil)
    assert {[1, 2], nil, 0} == Tree.add(2, non_full_leaf)
  end

  test "split leaf node" do
    full_leaf = Tree.add(2, Tree.add(1, nil))
    assert {[2], [{[1], nil, 0}, {[3], nil, 0}], 1} == Tree.add(3, full_leaf)

    # insert in different order works the same
    full_leaf = Tree.add(3, Tree.add(1, nil))
    assert {[2], [{[1], nil, 0}, {[3], nil, 0}], 1} == Tree.add(2, full_leaf)
  end

  test "keeps the tree balanced by mergin internal nodes from the right subtree" do
    tree = Enum.reduce([1, 2, 3, 4, 5], nil, fn(item, tree) -> Tree.add(item, tree) end)

    assert {[2, 4], [{[1], nil, 0}, {[3], nil, 0}, {[5], nil, 0}], 1} == tree
  end

  test "keeps the tree balanced by mergin internal nodes from the left subtree" do
    tree = Enum.reduce([1, 2, 3, -1, -2], nil, fn(item, tree) -> Tree.add(item, tree) end)

    assert {[-1, 2], [{[-2], nil, 0}, {[1], nil, 0}, {[3], nil, 0}], 1} == tree
  end

  test "root split by cascading left child split" do
    tree = Enum.reduce([2, 1, 3, 4, 5, -1, -2], nil, fn(item, tree) -> Tree.add(item, tree) end)

    expected = {[2],
      [{[-1], [{[-2], nil, 0}, {[1], nil, 0}], 1},
       {[4], [{[3], nil, 0}, {[5], nil, 0}], 1}], 2}

    assert tree == expected
  end

  test "root split by cascading middle child split" do
    tree = Enum.reduce([2, 1, 3, 4, 5, 3.5, 3.2], nil, fn(item, tree) -> Tree.add(item, tree) end)

    expected = {[3.2],
      [{[2], [{[1], nil, 0}, {[3], nil, 0}], 1},
       {[4], [{[3.5], nil, 0}, {[5], nil, 0}], 1}], 2}

    assert expected == tree
  end

  test "root split by cascading right child split" do
    tree = Enum.reduce([2, 1, 3, 4, 5, 6, 7], nil, fn(item, tree) -> Tree.add(item, tree) end)

    expected = {[4],
      [{[2], [{[1], nil, 0}, {[3], nil, 0}], 1},
       {[6], [{[5], nil, 0}, {[7], nil, 0}], 1}], 2}

    assert expected == tree
  end

  test "add item to left child with enough slots" do
    tree = Enum.reduce([2, 1, 3, 4, 5, -1], nil, fn(item, tree) -> Tree.add(item, tree) end)

    expected = {[2, 4], [{[-1, 1], nil, 0}, {[3], nil, 0}, {[5], nil, 0}], 1}

    assert tree == expected
  end

  test "add item to middle child with enough slots" do
    tree = Enum.reduce([2, 1, 3, 4, 5, 3.5], nil, fn(item, tree) -> Tree.add(item, tree) end)

    expected = {[2, 4], [{[1], nil, 0}, {[3, 3.5], nil, 0}, {[5], nil, 0}], 1}

    assert tree == expected
  end

  test "add item to right child with enough slots" do
    tree = Enum.reduce([2, 1, 3, 4, 5, 6], nil, fn(item, tree) -> Tree.add(item, tree) end)

    expected = {[2, 4], [{[1], nil, 0}, {[3], nil, 0}, {[5, 6], nil, 0}], 1}

    assert tree == expected
  end
end
