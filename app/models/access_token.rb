class AccessToken
  @@current = nil
  def self.current
    @@current
  end

  def self.current= access_token
    @@current = access_token
  end

  def initialize(token)
    @token = token
  end

  def token
    @token
  end
end
