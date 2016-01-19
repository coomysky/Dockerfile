#
# coomy/ubuntu:14.04
#
FROM ubuntu:14.04

MAINTAINER Coomy Chang <coomysky@gmail.com>


##### System update and install
RUN apt-get update -qq && apt-get upgrade -qq
RUN apt-get install -qqy openssh-server screen vim git curl


##### Create an user account and assign password to it
RUN useradd -m coomy && adduser coomy sudo && chsh -s /bin/bash coomy
RUN echo "coomy:coomy" | chpasswd


##### Join the user to sudoers
RUN echo 'coomy ALL=(ALL) NOPASSWD:ALL' > /tmp/coomy
RUN echo 'Defaults:coomy !requiretty' >> /tmp/coomy
RUN chmod 0440 /tmp/coomy
RUN chown root:root /tmp/coomy
RUN mv /tmp/coomy /etc/sudoers.d/coomy


##### Environment
ENV HOME /home/coomy
ENV SSH_RUN "/usr/sbin/sshd -D"


##### SSH setting
RUN sudo -u coomy /usr/bin/ssh-keygen -t ecdsa -N "" -f $HOME/.ssh/id_ecdsa
RUN sudo -u coomy /usr/bin/ssh-keygen -t rsa -N "" -f $HOME/.ssh/id_rsa
RUN mkdir -p /var/run/sshd
EXPOSE 22


##### Clean
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


##### Command
CMD ["/usr/sbin/sshd", "-D"]


##### For user
ONBUILD USER coomy
ONBUILD WORKDIR $HOME
ONBUILD RUN sudo -u coomy mkdir $HOME/start
ONBUILD RUN sudo -u coomy touch $HOME/start/run.bash
ONBUILD RUN echo "#!/bin/bash" >> $HOME/start/run.bash

