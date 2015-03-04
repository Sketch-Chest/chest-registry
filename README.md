# chest.pm

Source of chest.pm .

## Contributing

Please feel free to use a different markup language if you do not plan to run
__rake doc:app__.

# Policy

- Keep it simple.

# API

## login

POST http://chest.pm/api/sessions
email, password -> auth

## publish

POST http://chest.pm/api/packages
auth, metadata, (tarball) -> url

## unpublish

DELETE http://chest.pm/api/packages/NAME
auth -> status

## search

GET http://chest.pm/api/search
query -> array

## show

GET http://chest.pm/api/packages/NAME
-> dict
