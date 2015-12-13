json.(@package,
  :name,
  :description,
  :license,
  :homepage,
  :repository,
  :keywords,
  :authors,
  :created_at,
  :updated_at
)

json.version @package.versions.last.version

json.owner do
  json.name @package.user
end
