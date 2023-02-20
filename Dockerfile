ARG build_from=hexpm/elixir:1.14.2-erlang-25.1.2-debian-bullseye-20221004-slim
FROM $build_from as language-base

WORKDIR /app

COPY . ./
RUN mix local.hex --force && mix local.rebar --force

CMD mix deps.get && mix phx.server