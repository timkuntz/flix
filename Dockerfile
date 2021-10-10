FROM ruby:2.6.5

# https-based sources allows working with ssl sources
# libgnutls30 fixes a certificate expiration issue
#    https://github.com/nodesource/distributions/issues/1266
RUN apt-get update -yqq && \
    apt-get install -yqq --no-install-recommends \
      apt-transport-https \
      libgnutls30

# # Ensure we install a specific (major) version of Node
# # see https://github.com/nodesource/distributions
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -

# Ensure latest packages for Yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
  tee /etc/apt/sources.list.d/yarn.list

# Install packages
RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
      nodejs \
      yarn

# copy just the gemfile so other file changes
# do not bust the bundle install cache
COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app

ENV BUNDLE_PATH /gems
RUN bundle install

COPY . /usr/src/app/
RUN yarn install --check-files

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["bin/rails", "s", "-b", "0.0.0.0"]

# docker build . -t flix:latest
#
# docker run -i -t --rm -v ${PWD}:/usr/src/app flix bash
#
# docker run -p 3000:3000 flix
#
# docker run flix rails db:migrate
