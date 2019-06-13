# Use an official Elixir runtime as a parent image
FROM elixir:otp-22

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get update && \
  apt-get install -y postgresql-client nodejs

# Create app directory and copy the Elixir projects into it
RUN mkdir /app
COPY . /app
WORKDIR /app

# Install hex package manager
RUN mix local.hex --force
RUN mix deps.get
RUN cd assets && npm install && node node_modules/webpack/bin/webpack.js --mode development
RUN pwd
CMD ["/app/entrypoint.sh"]