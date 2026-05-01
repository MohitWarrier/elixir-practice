defmodule HttpChecker do
  def check(url) do
    case :httpc.request(:get, {String.to_charlist(url), []}, [], []) do
      {:ok, {{_, status, _}, _, _}} ->
        %{url: url, status: status, up: status < 400}

      {:error, _} ->
        %{url: url, status: :error, up: false}
    end
  end

  def check_all(url_list) do
    Enum.map(url_list, &check/1)
  end
end
