class User < ActiveRecord::Base
  acts_as_paranoid
  authenticates_with_sorcery! do |config|
    config.authentications_class = Authentication
  end

  has_many :authentications, dependent: :destroy
  has_many :packages

  accepts_nested_attributes_for :authentications

  # Validation
  validates :name, presence: true, uniqueness: true, length: { maximum: 20 },
                       format: { with: /\A[A-Za-z0-9_]+\z/ }
  validates :email, presence: true, uniqueness: true, email: true
  validates :password, presence: true, confirmation: true, length: { minimum: 3 }
  validates :password_confirmation, presence: true

  def has_linked_github?
    authentications.where(provider: 'github').present?
  end
end
