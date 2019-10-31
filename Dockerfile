FROM python:3.6

ENV PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache -r requirements.txt

RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update && apt-get install -y libssl1.1
RUN apt-get install -y postgresql postgresql-client postgresql-contrib
USER postgres
RUN /etc/init.d/postgresql start &&\
    psql --command "CREATE USER django WITH SUPERUSER PASSWORD 'django';" &&\
    psql --command "CREATE DATABASE django;"
USER root

EXPOSE 8000
EXPOSE 5432

CMD [ "/bin/bash" ]
