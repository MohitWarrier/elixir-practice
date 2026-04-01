defmodule ReverseList do



def reverse(list) do
  reverse(list, [])
end
def reverse([], acc) do
  acc
end
def reverse([head | tail], acc) do
  reverse(tail, [head | acc])
end

end
