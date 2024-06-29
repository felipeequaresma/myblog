# syntax = docker/dockerfile:1

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version and Gemfile
ARG RUBY_VERSION=3.2.1
FROM registry.docker.com/library/ruby:$RUBY_VERSION-slim as base

# Rails app lives here
WORKDIR /var/www/core

# Set development environment
ENV RAILS_ENV="development"

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential libpq-dev curl postgresql-client libvips pkg-config

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy application code
COPY . .

# Precompile bootsnap code for faster boot times
RUN bundle exec bootsnap precompile app/ lib/

# Run and own only the runtime files as a non-root user for security
# RUN useradd core --create-home --shell /bin/bash && \
#     chown -R core:core /var/www/core/tmp /var/www/core/log /var/www/core/storage /var/www/core/db

# Entrypoint prepares the database.
ENTRYPOINT ["/var/www/core/bin/docker-entrypoint"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/dev", "server", "-b", "0.0.0.0"]