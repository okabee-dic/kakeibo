class User < ApplicationRecord
  has_secure_password
  
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { maximum: 100 },
     format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  
  with_options if: :password do |user|
    user.validates :password, 
      on: :create,
      presence: { message: "パスワードを入力して下さい" },
      length: { minimum: 6 },
      confirmation: { allow_blank: true } 
    user.validates :password, 
      on: :update,
      presence: { message: "新しいパスワードを入力して下さい" },
      length: { minimum: 6 },
      confirmation: { allow_blank: true }
  end
  
  has_many :books, dependent: :destroy
end
