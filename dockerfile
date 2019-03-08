FROM ubuntu:18.04

RUN apt-get update
ENV TZ=America/Rochester
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 php libapache2-mod-php openssh-server
RUN service apache2 start
RUN useradd -ms /bin/bash alice
RUN echo "alice:root" | chpasswd
RUN adduser alice sudo

RUN git clone https://github.com/CSEC731-Geise/assignment5 ./webshell
RUN mv ./webshell/* /var/www/html

RUN openssl req -nodes -newkey rsa:2048 -keyout /etc/apache2/privkey.pem -x509 -days 365 -out /etc/apache2/pubcert.pem  -subj "/C=US/ST=NY/L=Rochester/O=RIT/OU=CSEC731/CN=localhost"

COPY ./apache.conf /etc/apache2/apache2.conf
COPY ./apache-site.conf /etc/apache2/sites-enabled/000-default.conf

COPY ./startup.sh /usr/local/bin/startup.sh
RUN chmod +x /usr/local/bin/startup.sh

EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/usr/local/bin/startup.sh"]
