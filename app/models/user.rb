class User < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  validates :name,  presence: true, length: { maximum: 50 }

  validates :surname,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_PESEL_REGEX = /\d{9}/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :pesel, presence: true,
                    format: { with: VALID_PESEL_REGEX }
  has_secure_password
  validates :password, length: { minimum: 6 }, allow_blank: true

  has_many :borrower_relationships, class_name:  "Possession",
                                    foreign_key: "borrower_id",
                                    dependent:   :destroy
  has_many :borrowed_copies, through: :borrower_relationships, source: :borrowed

  def place_order(copy)
    borrower_relationships.create(borrowed_id: copy.id)
  end

  def displace_order(copy)
    borrower_relationships.find_by(borrowed_id: copy.id).destroy
  end

  def borrow?(copy)
    borrowed_copies.include?(copy)
  end

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  private

    # Converts email to all lower-case.
    def downcase_email
      self.email = email.downcase
    end

end
User.index.create
User.import
User.tire.index.refresh
