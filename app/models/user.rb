class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :poolmemberships
  has_many :pools, through: :poolmemberships

  validates :name,
            length: {
              minimum: 2,
              maximum: 35,
              message: '* Je naam moet tussen de 2 en 35 karakters lang zijn.'
            }

  validates :nickname,
            length: {
              minimum: 2,
              maximum: 35,
              message: '* Je nickname moet tussen de 2 en 35 karakters lang zijn.'
            },
            uniqueness: {
              message: '* Deze alias is al bezet.'
            }

  validates :email,
            uniqueness: {
              message: '* Dit e-mail adres is al in gebruik.'
            },
            format: {
              with: /[a-zA-Z0-9._%-]+@(?:[a-zA-Z0-9-]+\.)+(com|net|org|info|biz|me|edu|gov|nl)/,
              message: 'Voer een geldig e-mail adres in!'
            }

  validates :password,
            presence: false,
            allow_blank: false,
            length: {
              minimum: 5,
              message: '* Het wachtwoord moet minimaal 5 karakters!'
            },
            confirmation: {
              message: '* De wachtwoorden komen niet overeen!'
            }
end
