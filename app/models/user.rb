class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
          
         validates :nickname,presence: true
         validates :first_name_kana,presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナのみで入力してください" }
         validates :last_name_kana,presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: "は全角カタカナのみで入力してください" }
         validates :first_name, presence: true, format: { with: /\A[一-龯ぁ-んァ-ン]+\z/, message: "は全角文字で入力してください" }
         validates :last_name, presence: true, format: { with: /\A[一-龯ぁ-んァ-ン]+\z/, message: "は全角文字で入力してください" }
         validates :birthday, presence: true
         

end
