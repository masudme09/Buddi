FROM elixir:latest

RUN apt-get update && \
  apt-get upgrade && \
  apt-get install -y npm && \
  apt-get install -y inotify-tools && \
  # apt-get install -y nodejs && \
  # curl -L https://npmjs.org/install.sh | sh && \
  mix local.hex --force && \
  mix archive.install hex phx_new 1.5.3 --force && \
  mix local.rebar --force

ENV REPLACE_OS_VARS=true MIX_ENV=prod

ENV APP_HOME /app
RUN mkdir ${APP_HOME}
WORKDIR ${APP_HOME}
COPY . .

CMD ["mix", "phx.server"]