# How to contribute

We strongly welcome your contribution!

## Build

```console
$ docker-compose run web bundle exec rake db:migrate
$ docker-compose up
```

## Test

In first, follow the setup guides above under [Build](#build).

```console
$ docker-compose run web bundle exec rspec
```

## Create a pull request

1. Fork the repo.
2. Run all tests and make them pass.
3. Push to your fork and submit a pull request.
