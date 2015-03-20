class Package < ActiveRecord::Base
  belongs_to :user
  has_many :versions, dependent: :destroy

  # Validation
  validates_uniqueness_of :name
  validates :name, presence: true, length: { maximum: 30 }, format: { with: /\A[A-Za-z0-9_-]+\z/ }
  validates :user, presence: true

  serialize :authors
  serialize :keywords

  before_save :generate_readme_html

  # use :name as primary key instead of :id
  def to_param
    name
  end

  def increase_download_count
    self.download_count += 1
    self.save
  end

  private
  def generate_readme_html
    md = Kramdown::Document.new(self.readme)

    # Preprocess
    md.root.children.shift if md.root.children.first.type == :header

    self.readme_html = md.to_html
  end
end
