FROM ubuntu:16.04
MAINTAINER moremagic <itoumagic@gmail.com>

RUN apt-get update && apt-get install -y openssh-server openssh-client
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin .*$/PermitRootLogin yes/' /etc/ssh/sshd_config

# Java install
RUN apt-get install -q -y openjdk-8-* && apt-get clean
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
ENV PATH $JAVA_HOME/bin:$PATH

# Scala install
RUN apt-get install -y scala

# Apache-kafka install
RUN wget -q http://ftp.kddilabs.jp/infosystems/apache/kafka/0.10.1.0/kafka_2.11-0.10.1.0.tgz
RUN mkdir kafka && tar -xvzf kafka_*.tgz -C kafka --strip-components 1

# sbtのインストール
RUN apt-get install -y unzip && wget https://dl.bintray.com/sbt/debian/sbt-0.13.7.deb
RUN apt-get update
RUN dpkg -i sbt-0.13.7.deb

# Trifecta install
RUN wget -q https://github.com/ldaniels528/trifecta/releases/download/v0.21.3/trifecta_ui-0.21.3.zip && unzip trifecta_ui-0.21.3.zip
#RUN apt-get install -y git
#RUN git clone https://github.com/ldaniels528/trifecta.git
#RUN sbt clean assembly
#wget https://github.com/ldaniels528/trifecta/releases/download/v0.21.3/trifecta_cli_0.21.3.bin.jar

# start shell append
COPY service.sh /etc/
RUN chmod +x /etc/service.sh

EXPOSE 22 9092 9000 
CMD ["/etc/service.sh", ""]

