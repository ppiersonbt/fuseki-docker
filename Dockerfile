# Creates Fuseki
#
# docker build -t fuseki-docker .

FROM centos
MAINTAINER ppierson@bericotechnologies.com

ADD artifacts /tmp/artifacts

RUN yum install git which wget -y

RUN wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.rpm && yum install ./jdk-8u* -y

RUN JAVA_HOME=/usr/java/latest/

RUN curl -s http://mirror.reverse.net/pub/apache/maven/maven-3/3.3.3/binaries/apache-maven-3.3.3-bin.tar.gz | tar xzv -C /opt

RUN mv /opt/apache-maven* /opt/maven

RUN ln -s /opt/maven/bin/mvn /bin/

RUN mkdir /working && cd /working && git clone https://github.com/apache/jena.git
RUN cd /working/jena/jena-fuseki2/ && mvn clean install
RUN mkdir /opt/fuseki2

RUN tar -zxvf /working/jena/jena-fuseki2/apache-jena-fuseki/target/apache-jena-fuseki-2.3.1-SNAPSHOT.tar.gz -C /opt/fuseki2

RUN chmod +x /opt/fuseki2/apache-jena-fuseki-2.3.1-SNAPSHOT/fuseki-server

RUN rm -R /working

RUN mv /tmp/artifacts/startup.sh /opt/fuseki2/apache-jena-fuseki-2.3.1-SNAPSHOT/startup.sh
RUN chmod +x /opt/fuseki2/apache-jena-fuseki-2.3.1-SNAPSHOT/startup.sh

RUN mkdir /data
VOLUME /data
EXPOSE 3030
CMD ["/opt/fuseki2/apache-jena-fuseki-2.3.1-SNAPSHOT/startup.sh"]
