class VersionValidator < ActiveModel::Validator
  def validate(record)
    return unless record.package.versions.count > 0
    unless Semantic::Version.new(record.version) > Semantic::Version.new(record.class.last.version)
      record.errors[:version] << 'Must be bigger than exists'
    end
  end
end

class Version < ActiveRecord::Base
  belongs_to :package

  has_attached_file :archive

  validates :version, presence: true
  validates_with VersionValidator
  validates :package, presence: true
  validates :archive, presence: true
  validates_attachment_content_type :archive, content_type: /\Aapplication\/zip\Z/

  def semver
    Semantic::Version.new(self.version)
  end
end
