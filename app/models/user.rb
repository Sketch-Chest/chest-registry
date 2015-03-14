class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:github]

  include Tokenable

  has_many :packages

  # Validation
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 },
                       format: { with: /\A[a-z0-9_]+\z/ }
  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true, confirmation: true, length: { minimum: 3 }

  # use :name as primary_key instead of :id
  def to_param
    name
  end

  # Use for authenticate with GitHub
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end

  # Use for registration after authenticate with GitHub
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.github_data']
        user.email = data['info']['email'] if user.email.blank?
        user.name  = data['info']['nickname'] if user.name.blank?
      end
    end
  end
end
