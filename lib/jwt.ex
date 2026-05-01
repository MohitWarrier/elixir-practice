defmodule JWT do

  # sign/2 — takes a payload map and a secret string, returns a JWT token string
  # format: base64url(header) <> "." <> base64url(payload) <> "." <> base64url(signature)
  # header is always: %{"alg" => "HS256", "typ" => "JWT"}
  # signature is: HMAC-SHA256(header_part <> "." <> payload_part, secret)
  def sign(payload, secret) do
  end

  # verify/2 — takes a token string and a secret, returns {:ok, payload} or {:error, reason}
  # {:error, :invalid_token}     — token is not three parts
  # {:error, :invalid_signature} — signature doesn't match
  def verify(token, secret) do
  end

end
