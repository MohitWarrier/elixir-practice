defmodule TcpEchoServerTest do
  use ExUnit.Case

  @port 4040

  # Start the server once for all tests in this file
  setup_all do
    {:ok, _pid} = TcpEchoServer.start(@port)
    :ok
  end

  test "echoes back a single message" do
    {:ok, socket} = :gen_tcp.connect({127, 0, 0, 1}, @port, [:binary, packet: :line, active: false])
    :gen_tcp.send(socket, "hello\n")
    {:ok, response} = :gen_tcp.recv(socket, 0, 1000)
    assert response == "hello\n"
    :gen_tcp.close(socket)
  end

  test "echoes multiple messages on the same connection" do
    {:ok, socket} = :gen_tcp.connect({127, 0, 0, 1}, @port, [:binary, packet: :line, active: false])
    :gen_tcp.send(socket, "first\n")
    {:ok, r1} = :gen_tcp.recv(socket, 0, 1000)
    :gen_tcp.send(socket, "second\n")
    {:ok, r2} = :gen_tcp.recv(socket, 0, 1000)
    assert r1 == "first\n"
    assert r2 == "second\n"
    :gen_tcp.close(socket)
  end

  test "handles multiple clients at the same time" do
    {:ok, s1} = :gen_tcp.connect({127, 0, 0, 1}, @port, [:binary, packet: :line, active: false])
    {:ok, s2} = :gen_tcp.connect({127, 0, 0, 1}, @port, [:binary, packet: :line, active: false])

    :gen_tcp.send(s1, "client1\n")
    :gen_tcp.send(s2, "client2\n")

    {:ok, r1} = :gen_tcp.recv(s1, 0, 1000)
    {:ok, r2} = :gen_tcp.recv(s2, 0, 1000)

    assert r1 == "client1\n"
    assert r2 == "client2\n"

    :gen_tcp.close(s1)
    :gen_tcp.close(s2)
  end

  test "connection closes cleanly when client disconnects" do
    {:ok, socket} = :gen_tcp.connect({127, 0, 0, 1}, @port, [:binary, packet: :line, active: false])
    :gen_tcp.close(socket)
    # server should not crash — other tests still pass after this
  end
end