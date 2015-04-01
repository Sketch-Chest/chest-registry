FactoryGirl.define do
  factory :version do
    version '1.0.0'
    archive_file_name 'Sketch-Plugin.zip'
    archive_content_type 'application/zip'
    archive_file_size 1024
    archive_updated_at { Time.now }
    package
  end
end
