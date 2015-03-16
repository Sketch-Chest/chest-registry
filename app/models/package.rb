class Package < ActiveRecord::Base
  belongs_to :user
  has_many :versions, dependent: :destroy

  # Validation
  validates_uniqueness_of :name, scope: :deleted_at
  validates :name, presence: true, length: { maximum: 20 }, format: { with: /\A[A-Za-z0-9_-]+\z/ }
  validates :user, presence: true

  before_create :generate_readme_html

  # use :name as primary key instead of :id
  def to_param
    name
  end

  private
  def generate_readme_html
    md = Kramdown::Document.new(self.readme)

    # Preprocess
    md.root.children.shift if md.root.children.first.type == :header

    self.readme_html = md.to_html
  end
end
