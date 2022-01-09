FROM tiangolo/uvicorn-gunicorn-fastapi:python3.7-2021-06-09 AS build

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/debian/10/prod.list > /etc/apt/sources.list.d/mssql-release.list

RUN apt-get update && apt-get install -y --no-install-recommends apt-utils && \
    apt-get install -y unixodbc-dev && ACCEPT_EULA=Y apt-get install -y msodbcsql17 && \
    apt-get install net-tools -y

FROM build

#ARGS
ENV LISTEN_PORT 6969
ENV PORT 6969
EXPOSE 6969
ENV PYTHON_SOLUTION_PATH='/app'
ENV MODULE_NAME=TestAPI.app
ENV VARIABLE_NAME=app
# ENV GUNICORN_CMD_ARGS="--limit-request-line 4096 --limit-request-fields 100 --limit-request-field_size 8192"

# copy files
COPY ./TestAPI/ /app/TestAPI/
COPY ./Core /app/Core

# copy shared files
COPY ./share /app/share

# install python dependencies
WORKDIR /app/TestAPI
RUN pip install --upgrade pip && pip3 install -r /app/TestAPI/requirements.txt

# RUN make test

# to build, use the following
# docker build -t testapi_image:latest -f ./fastAPI-MSSQL-ODBC.Dockerfile ./
# docker run -it --rm --name testapi_container -p 6969:6969 testapi_image:latest

# use this to run gunicorn locally
# gunicorn -k uvicorn.workers.UvicornWorker app:app -b 127.0.0.1:6969
