class User < ApplicationRecord
  # Llamada original #  before_save { self.email = email.downcase }
  before_save { email.downcase! } # Llamada con metodo "bang!"
  validates :name, presence: true, length: { maximum: 50 }
  # Exp Reg Original VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
end
