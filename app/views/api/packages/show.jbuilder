json.extract! @package, :name, :description, :tarball_url
json.set! :author do
  json.extract! @package.user, :name
end
