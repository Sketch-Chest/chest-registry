class Version < ActiveRecord::Base
  belongs_to :package

  has_attached_file :archive

  validates :version, presence: true
  validates :package, presence: true
  validates :archive, presence: true
  validates_attachment_content_type :archive, content_type: /\Aapplication\/zip\Z/

  def semver
    Semantic::Version.new(self.version)
  end
end
