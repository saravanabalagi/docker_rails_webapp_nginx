FROM ruby

ENV PORT 3000
ARG RAILS_ROOT=/app
ARG TMPDIR=/tmp
ARG SERVER_SRC_PATH=./server
WORKDIR $RAILS_ROOT

# Install dependencies
RUN gem install rails bundler
RUN apt update -qq && apt install -y nodejs

# Pre-install gems
COPY ${SERVER_SRC_PATH}/Gemfile* ${TMPDIR}/
RUN cd ${TMPDIR} && \
        gem install bundler && \
        bundle install

EXPOSE $PORT
CMD bundle exec rails s -b 0.0.0.0 -p 3000
