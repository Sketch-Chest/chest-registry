class User < ActiveRecord::Base
  acts_as_paranoid

  has_many :packages
end
