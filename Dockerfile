FROM elixir:otp-22

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && \
  apt-get install -y postgresql-client nodejs

RUN mkdir /app
COPY . /app
WORKDIR /app

RUN mix local.hex --force
RUN mix deps.get
RUN mix local.rebar --force
RUN cd assets && npm install -f && node node_modules/webpack/bin/webpack.js --mode development
CMD ["/app/entrypoint.sh"]  