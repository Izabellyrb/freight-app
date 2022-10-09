class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum function: {regular_user: 0, admin: 1}

  validates :name, presence: true
  validates :email, format: { with: /\A[^@\s]+@sistemadefrete.com.br/,
    message: "não é valido, domínio incorreto" }

end
