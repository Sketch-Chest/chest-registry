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
end
