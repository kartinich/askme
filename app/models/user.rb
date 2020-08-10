require 'openssl'

class User < ApplicationRecord

  VALID_EMAIL_REGEX = /\A[\w+\-]+\@[\w+\-]+\.\w+\z/.freeze
  VALID_USERNAME_REGEX = /\A\w+\z/.freeze
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new

  attr_accessor :password

  has_many :questions

  validates :username, presence: true,
                       uniqueness: true,
                       format: { with: VALID_USERNAME_REGEX },
                       length: { maximum: 40 }

  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX }

  validates :password, presence: true, on: :create, confirmation: true

  before_validation :username_downcase
  before_save :encrypt_password

  private

  def username_downcase
    self.username = username&.downcase
  end

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))

      self.password_hash = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
          password, password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
      )
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    # Сперва находим кандидата по email
    user = find_by(email: email)

    # Если пользователь не найдет, возвращаем nil
    return nil unless user.present?

    # Формируем хэш пароля из того, что передали в метод
    hashed_password = User.hash_to_string(
      OpenSSL::PKCS5.pbkdf2_hmac(
        password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
      )
    )

    # Обратите внимание: сравнивается password_hash, а оригинальный пароль так
    # никогда и не сохраняется нигде. Если пароли совпали, возвращаем
    # пользователя.
    return user if user.password_hash == hashed_password

    # Иначе, возвращаем nil
    nil
  end
end
