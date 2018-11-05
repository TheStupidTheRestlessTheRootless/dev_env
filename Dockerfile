FROM docker.geekandchef.com/ubuntu:18.04

# Must have packages
RUN rm /bin/sh && ln -s /bin/bash /bin/sh \
    && apt-get update \
    && apt-get install -y software-properties-common \ 
    && apt-get install -y vim nano curl git libffi-dev make build-essential python-dev python-pip libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev

# java jkd
RUN apt-get install -y openjdk-8-jdk 

# set evn
ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv 
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH 

# install python 
RUN git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv \
    && echo 'export PYENV_ROOT="$HOME/.pyenv"' >> $HOME/.bashrc \
    && echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> $HOME/.bashrc \
    && echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> $HOME/.bashrc \
    && pyenv install 3.7.0 \
    && pyenv global 3.7.0

# install node
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash 

ENV NODE_VERSION 8.11.2
ENV NVM_DIR $HOME/.nvm

RUN source $NVM_DIR/nvm.sh && nvm install $NODE_VERSION \
    && nvm alias default $NODE_VERSION \
    && nvm use default

ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
ENV NOTVISIBLE "in users profile"


RUN apt-get install -y tmux \
    && apt-get install -y openssh-server \
    && mkdir /var/run/sshd \
    && echo "root:yourRootPassWord" | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && echo "export VISIBLE=now" >> /etc/profile

# SSH login fix. Otherwise user is kicked off after login



# Add none root user
# RUN  useradd geek && echo "geek:geek" | chpasswd && adduser geek sudo
# USER geek
# WORKDIR /home/geek
VOLUME [ "/data" ]
EXPOSE 22
WORKDIR /root
CMD /usr/sbin/sshd && bash
# CMD /bin/bash
