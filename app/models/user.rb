class User < ActiveRecord::Base
  include Tokenable

  acts_as_paranoid

  authenticates_with_sorcery!

  has_many :packages

  # Validation
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 },
                       format: { with: /\A[A-Za-z0-9_]+\z/ }
  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true, confirmation: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true

  # use :name as primary_key instead of :id
  def to_param
    name
  end
end
