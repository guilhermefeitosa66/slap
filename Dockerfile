FROM ruby:2.5.9

LABEL version="1.0"
LABEL description="Aplicação Ruby on Rails para levantamento e avaliação patrimonial"
LABEL maintainer="Guilherme Feitoza - guilhermefeitosa66@gmail.com"

# copy app files to folder into container
RUN mkdir -p /slap
WORKDIR /slap
COPY ./* /slap/

# set enviroment variables
ENV RAILS_ENV=production
ENV POSTGRES_HOST=db

# configure archived debian repositories
RUN echo "deb http://archive.debian.org/debian buster main" > /etc/apt/sources.list && \
  echo "deb http://archive.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list && \
  echo "Acquire::Check-Valid-Until false;" > /etc/apt/apt.conf.d/99no-check-valid-until

# install dependencies
RUN apt update && apt install -y build-essential nodejs libpq-dev && apt clean
RUN bundle install

# executed every time the container starts.
COPY ./startup.sh /slap/
RUN chmod +x startup.sh
ENTRYPOINT ["./startup.sh"]

# expose ports to access the webapp
EXPOSE 3000

# Configure the main process to run when running the image
# CMD ["rails", "server", "-e", "production", "-b", "0.0.0.0"]