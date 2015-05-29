# How to contribute

We strongly welcome your contribution!

## Build

```console
$ cd chest-registry
$ bundle install
$ bundle exec rake db:migrate
$ bin/rails s
```

## Test

In first, follow the setup guides above under [Build](#build).

```console
$ rspec
```

## Create a pull request

1. Fork the repo.
2. Run all tests and make them pass. `$ rspec`
3. Push to your fork and submit a pull request.
