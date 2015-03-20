json.(@package,
  :name,
  :description,
  :license,
  :homepage
)

json.version @package.versions.last.version

json.author do
  json.name @package.user
end
