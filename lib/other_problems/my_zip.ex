defmodule MyZip do

  # base case - any time either list is [] return []
  def zip([],_) do
    []
  end

  def zip(_,[]) do
    []
  end

  def zip([head1|tail1], [head2|tail2]) do
    [{head1,head2} | zip(tail1,tail2)]
  end

end
