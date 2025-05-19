# Use official Elixir image
FROM elixir:1.15-alpine

# Install dependencies
RUN apk add --no-cache build-base npm git

# Set environment
ENV MIX_ENV=prod

# Set workdir
WORKDIR /app

# Copy files
COPY mix.exs mix.exs
COPY mix.lock mix.lock

# Install Elixir deps
RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get --only prod

# Copy the rest of the application
RUN mv mix.exs mix.exs.new && \
    mv mix.lock mix.lock.new

COPY . .

RUN rm mix.exs && \
    rm mix.lock
RUN mv mix.exs.new mix.exs && \
    mv mix.lock.new mix.lock

RUN MIX_ENV=prod mix compile

# Build assets
# RUN cd assets && npm install && npm run deploy

RUN mix assets.deploy

# Expose port
EXPOSE 4000

# Run the server
CMD ["mix", "phx.server"]

