FROM ubuntu
MAINTAINER Shane Kilkelly <shane@kilkelly.me>


# Exposes
EXPOSE 5432


# Credentials
ENV USERNAME docker
ENV PASS docker


RUN apt-key adv --keyserver keyserver.ubuntu.com \
  --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

RUN echo \
  "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" \
  > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update


RUN apt-get -y -q install \
  python-software-properties \
  software-properties-common

RUN apt-get -y -q install \
  postgresql-9.3 \
  postgresql-client-9.3 \
  postgresql-contrib-9.3


ADD pg_hba.conf     /etc/postgresql/9.3/main/
ADD pg_ident.conf   /etc/postgresql/9.3/main/
ADD postgresql.conf /etc/postgresql/9.3/main/


# main entry
ADD start /start
RUN chmod 0755 /start


CMD ["/start"]
