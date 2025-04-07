class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  VALID_KANA_NAME_REGEX = /\A[ァ-ヶー]+\z/
  VALID_PASSWORD_REGEX =  /\A(?=.*[A-Za-z])(?=.*\d)[\x20-\x7E]{6,}\z/

  with_options presence: true do
    validates :nickname
    # ひらがな、カタカナ、漢字のみ許可する
    validates :first_name, format: { with: VALID_NAME_REGEX, message: 'is invalid. Input full-width characters.' }
    validates :last_name, format: { with: VALID_NAME_REGEX, message: 'is invalid. Input full-width characters.' }
    # カタカナのみ許可する
    validates :first_kana_name,
              format: { with: VALID_KANA_NAME_REGEX, message: 'is invalid. Input full-width katakana characters.' }
    validates :last_kana_name,
              format: { with: VALID_KANA_NAME_REGEX, message: 'is invalid. Input full-width katakana characters.' }
    validates :email, uniqueness: { case_sensitive: false }
    validates :password_confirmation
    validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'must include at least one letter and one digit, and only use half-width characters.' },
                         length: { minimum: 6 }
    validates :birth_day
  end
end
