defmodule TcpEchoServer do
  # start/1 — opens a listening socket on the given port,
  # spawns a process to accept connections, returns {:ok, pid}
  def start(port) do
    {:ok, listen_socket} =
      :gen_tcp.listen(port, [:binary, packet: :line, active: false, reuseaddr: true])

    pid = spawn(fn -> accept_loop(listen_socket) end)
    {:ok, pid}
  end

  # accept_loop/1 — waits for a client to connect.
  # when one connects, spawns a new process to handle that client,
  # then loops back to wait for the next client.
  defp accept_loop(listen_socket) do
    {:ok, client_socket} = :gen_tcp.accept(listen_socket)

    _pid = spawn(fn -> handle_client(client_socket) end)
    accept_loop(listen_socket)
  end

  # handle_client/1 — reads one line from the client,
  # sends it back, then loops to read the next line.
  # stops when the client disconnects.
  defp handle_client(socket) do
    case :gen_tcp.recv(socket, 0) do
      {:ok, data} ->
        :gen_tcp.send(socket, data)
        handle_client(socket)

      {:error, :closed} ->
        :ok
    end
  end
end
