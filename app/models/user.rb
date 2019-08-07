class User < ApplicationRecord
  # before_validation :ensure_session_token
  after_initialize :ensure_session_token
  attr_reader :password

  validates :session_token, :password_digest, :password, :username, presence: true
  validates :password, length: { minimum: 6 }, allow_nil: true

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64
  end

  def reset_session_token
    self.session_token = SecureRandom::urlsafe_base64
    self.save!
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end
