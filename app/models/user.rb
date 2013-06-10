class User < ActiveRecord::Base
  has_many :expenses

  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates_presence_of :password, :on => :create

  before_create :generate_auth_token

  def send_password_reset
    generate_password_reset_token
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  private

    def generate_auth_token
      generate_token :auth_token
    end

    def generate_password_reset_token
      generate_token :password_reset_token
    end

    def generate_token column
      begin
        self[column] = SecureRandom.urlsafe_base64(32)
      end while self.class.exists?(column => self[column])
    end
end
