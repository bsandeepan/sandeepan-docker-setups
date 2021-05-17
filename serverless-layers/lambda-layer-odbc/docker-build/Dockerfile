# Authored By: Sandeepan Bhattacharyya <bsandeepan95.work@gmail.com>
FROM amazonlinux:2

COPY ./ ./

# install developer tools (should contain gcc, gcc-c++, zip) and python 3.7
RUN yum clean all && yum update -y && \
    yum groupinstall -y "Development Tools" && \
    yum install -y python37 && \
    yum install -y python3-pip && \
    curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssql-release.repo

# Set up python 3.7 virtual env for the packaging
RUN python3.7 -m pip install --upgrade pip && \
    python3.7 -m venv layer && mkdir /python

# Manually install latest unixodbc to /var/task as happens in lambda
RUN mkdir /home/ec && cd /home/ec && \
    curl -O ftp://ftp.unixodbc.org/pub/unixODBC/unixODBC-2.3.9.tar.gz && \
    tar xvzf unixODBC-2.3.9.tar.gz && cd unixODBC-2.3.9 && \
    ./configure  --sysconfdir=/var/task  --disable-gui --disable-drivers --enable-iconv --with-iconv-char-enc=UTF8 --with-iconv-ucode-enc=UTF16LE  --prefix=/home && \
    make install && cd /

# install python3 and unixodbc devel packages
RUN yum install -y python3-devel unixODBC-devel

#  Copy unixODBC files to /source
RUN cd /home/ && rm -rf ./ec && cp -r ./ /source && cd /

# install SQL Server ODBC Driver
RUN ACCEPT_EULA=Y yum install -y msodbcsql17 && \
    cp -r /opt/microsoft/msodbcsql17 /source

# install PostgreSQL ODBC Driver
RUN yum install -y postgresql-odbc && mkdir -p /source/psqlodbc/lib64 && \
    cp /usr/lib64/{psqlodbcw.so,libodbcpsqlS.so} /source/psqlodbc/lib64
