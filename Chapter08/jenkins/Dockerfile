FROM jenkins

USER root
RUN apt-get update && \
    apt-get install -y ansible \
                       awscli \
                       python-boto

USER jenkins
