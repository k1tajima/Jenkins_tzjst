FROM jenkins/jenkins:lts
LABEL maintainer="Keiichi TAJIMA<k1tajima@mi.to>"

# comment

# set timezone for Java runtime arguments
ENV JAVA_OPTS=-Duser.timezone=Asia/Tokyo

# set timezone for OS by root
USER root
RUN ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# drop back to the regular jenkins user - good practice
USER jenkins