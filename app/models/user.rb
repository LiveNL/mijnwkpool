class User < ActiveRecord::Base
  has_secure_password validations: false

  has_many :poolmemberships
  has_many :pools, through: :poolmemberships
  has_many :predictions, through: :poolmemberships

  before_validation :downcase_email

  after_create :subscribe, if: :subscribed?

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
              message: '* Dit e-mailadres is al in gebruik.'
            },
            format: {
              with: /[a-zA-Z0-9._%-]+@(?:[a-zA-Z0-9-]+\.)+(com|net|org|info|biz|me|edu|gov|nl)/,
              message: 'Voer een geldig e-mailadres in.'
            }

  validates :password,
            presence: false,
            allow_blank: false,
            length: {
              minimum: 5,
              message: '* Het wachtwoord moet minimaal 5 karakters zijn.'
            },
            confirmation: {
              message: '* De wachtwoorden komen niet overeen.'
            },
            if: :password

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def subscribe
    mailchimp = Gibbon::API.new
    result = mailchimp.lists.subscribe({
      :id => ENV['MAILCHIMP_LIST_ID'],
      :email => {:email => self.email},
      :double_optin => false,
      :update_existing => true,
      :send_welcome => true
    })
    Rails.logger.info("Subscribed #{self.email} to MailChimp") if result
  end

  private

  def downcase_email
    self.email = self.email.downcase if self.email.present?
  end
end
