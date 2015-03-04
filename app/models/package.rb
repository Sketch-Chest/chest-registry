class Package < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :user

  # use :name as primary_key instead of :id
  def to_param
    name
  end
end
