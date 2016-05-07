class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:github]

  include Tokenable

  has_many :packages

  # Validation
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 },
                      format: { with: /\A[a-z0-9_]+\z/ }

  # use :name as primary_key instead of :id
  def to_param
    name
  end

  # omniauth existence
  def omniauth_connected?
    self.provider.present?
  end

  # Use for authenticate & create account with GitHub
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.nickname
      user.password = Devise.friendly_token[0,20]
    end
  end
end
