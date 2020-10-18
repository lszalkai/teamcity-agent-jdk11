FROM jetbrains/teamcity-agent

USER root

RUN curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN mkdir /opt/java/jdk-11

RUN curl -fsSL https://github.com/AdoptOpenJDK/openjdk11-upstream-binaries/releases/download/jdk-11.0.8%2B10/OpenJDK11U-jdk_x64_linux_11.0.8_10.tar.gz | tar -xvzf - -C /opt/java/jdk-11 --strip-components=1 

ENV JDK_11_64 /opt/java/jdk-11

ENV JRE_HOME /opt/java/jdk-11
ENV JAVA_HOME /opt/java/jdk-11
ENV PATH="$JAVA_HOME/bin:$PATH"

RUN update-alternatives --install /usr/bin/java java ${JRE_HOME}/bin/java 1 && \
    update-alternatives --set java ${JRE_HOME}/bin/java && \
    update-alternatives --install /usr/bin/javac javac ${JAVA_HOME}/bin/javac 1 && \
    update-alternatives --set javac ${JAVA_HOME}/bin/javac
