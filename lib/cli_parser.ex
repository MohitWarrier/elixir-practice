defmodule CliParser do

  def parse(tokens) do

   res =
   Enum.reduce_while(tokens, %{}, fn token, acc ->

      case token do

        "--" -> {:halt, {:error, "malformed argument: --"}}

        "--" <> rest ->

          cond do

            String.contains?(rest, "=") ->
              contents = String.split(rest, "=")
              option = hd(contents)
              value = tl(contents) |> Enum.join("=")
              new_acc = Map.put(acc, String.to_atom(option), value)
              {:cont, new_acc}

            String.contains?(rest, "-") ->
              new_val = String.split(rest, "-") |> Enum.join("_")
              new_acc = Map.put(acc, String.to_atom(new_val), true)
              {:cont, new_acc}

            true -> new_acc = Map.put(acc, String.to_atom(rest), true)
              {:cont, new_acc}

          end

        args ->
          new_acc = Map.update(acc, :args, [args], fn val -> val ++ [args] end)
          {:cont, new_acc}

      end

    end)

    case res do
      {:error, _msg} = err -> err
      map -> {:ok, map}
    end
  end

end
