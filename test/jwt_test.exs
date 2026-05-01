defmodule JWTTest do
  use ExUnit.Case

  test "sign produces a three-part token" do
    token = JWT.sign(%{"user_id" => 1}, "secret")
    assert length(String.split(token, ".")) == 3
  end

  test "verify returns the payload for a valid token" do
    payload = %{"user_id" => 1, "name" => "alice"}
    token = JWT.sign(payload, "secret")
    assert JWT.verify(token, "secret") == {:ok, payload}
  end

  test "verify fails with wrong secret" do
    token = JWT.sign(%{"user_id" => 1}, "secret")
    assert JWT.verify(token, "wrong_secret") == {:error, :invalid_signature}
  end

  test "verify fails with tampered payload" do
    token = JWT.sign(%{"user_id" => 1}, "secret")
    [header, _payload, sig] = String.split(token, ".")
    tampered_payload = Base.url_encode64(~s({"user_id":999}), padding: false)
    tampered = header <> "." <> tampered_payload <> "." <> sig
    assert JWT.verify(tampered, "secret") == {:error, :invalid_signature}
  end

  test "verify fails with malformed token" do
    assert JWT.verify("badtoken", "secret") == {:error, :invalid_token}
    assert JWT.verify("only.two", "secret") == {:error, :invalid_token}
  end
end
