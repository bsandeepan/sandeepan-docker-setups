FROM mcr.microsoft.com/mssql/server:2017-latest

RUN mkdir -p /opt/scripts
COPY ./seed/seed.sql /opt/scripts/

ENV SA_PASSWORD=Passw@rd
ENV ACCEPT_EULA=Y

RUN ( /opt/mssql/bin/sqlservr &) | grep -q "Service Broker manager has started" \
    && /opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P 'Passw@rd' -d master -i /opt/scripts/seed.sql
