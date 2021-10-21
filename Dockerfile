FROM ruby:2.6.6

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