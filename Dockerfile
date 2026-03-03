FROM ruby:3.2-bullseye
#FROM ruby:3.2

# Instalar dependencias del sistema y Yarn
RUN apt-get update -qq \
  && apt-get install -y curl gnupg \
  && curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | gpg --dearmor -o /usr/share/keyrings/yarn.gpg \
  && echo "deb [signed-by=/usr/share/keyrings/yarn.gpg] https://dl.yarnpkg.com/debian stable main" \
      > /etc/apt/sources.list.d/yarn.list \
  && apt-get update -qq \
  && apt-get install -y \
       build-essential \
       libmariadb-dev-compat \
       libmariadb-dev \
       nodejs \
       wkhtmltopdf \
       yarn \
       git \
       imagemagick \
  && rm -rf /var/lib/apt/lists/*
#RUN ln -s /usr/bin/wkhtmltopdf /usr/local/bin/wkhtmltopdf

WORKDIR /app

# Bundler moderno
RUN gem install bundler -v 2.5.11

COPY Gemfile ./
RUN bundle install

COPY . .

CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
