from debian:jessie

RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list.d/jessie-backports.list
RUN apt-get update
RUN apt-get -y install make g++ vim
RUN apt-get -y install -t jessie-backports  openjdk-8-jdk ca-certificates-java
ADD run.sh /run.sh
RUN chmod +x /run.sh
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/
WORKDIR /workdir
ENTRYPOINT ["/run.sh"]
