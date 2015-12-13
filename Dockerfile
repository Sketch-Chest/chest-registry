FROM rails:4.2.5

WORKDIR /app
ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install -j4
ADD . /app

EXPOSE 3000
