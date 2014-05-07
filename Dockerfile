FROM jwaldrip/rbenv
MAINTAINER Jason Waldrip <jason@waldrip.net>

# Install Node.js for sprockets
RUN add-apt-repository -y ppa:chris-lea/node.js && apt-get update
RUN apt-get install -y nodejs

# Set up the base image
ADD .ruby-version /.ruby-version
ENV PATH /app/vendor/bundle/bin:$PATH
ENV RAILS_ENV development
WORKDIR /
RUN rbenv setup

# Update Ruby Build
ONBUILD RUN cd $HOME/.rbenv/plugins/ruby-build && git pull origin master

# App Build Scripts
ONBUILD ADD . /app
ONBUILD WORKDIR /app
ONBUILD RUN if [ ! -e .ruby-version ] ; then ln -s /.ruby-version .ruby-version ; fi
ONBUILD RUN rbenv setup
