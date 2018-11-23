FROM docker.geekandchef.com/ubuntu:18.04

# Must have packages
RUN rm /bin/sh && ln -s /bin/bash /bin/sh \
    && apt-get update \
    && apt-get install -y software-properties-common \ 
    && apt-get install -y vim nano curl git libffi-dev make build-essential python-dev python-pip libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev gcc g++ cmake ctags

# java jkd
RUN apt-get install -y openjdk-8-jdk 

# set evn
ENV HOME /root
ENV PYENV_ROOT $HOME/.pyenv 
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH 
ENV PY_VERSION 3.7.0

# add install py script
ADD ./install_py.sh /usr/local

# install python 
RUN chmod +x /usr/local/install_py.sh \
    &&/usr/local/install_py.sh

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


# install tmux
RUN apt-get install -y tmux \
    && apt-get install -y openssh-server \
    && mkdir /var/run/sshd \
    && echo "root:yourRootPassWord" | chpasswd \
    && sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
    && sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd \
    && echo "export VISIBLE=now" >> /etc/profile

# install dart
RUN apt-get -q update && apt-get install --no-install-recommends -y -q curl git ca-certificates apt-transport-https openssh-client \
    && curl https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && curl https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list \
    && apt-get update \
    && apt-get install dart \
    && rm -rf /var/lib/apt/lists/* \
    && echo 'export DART_SDK="/usr/lib/dart"' >> $HOME/.bashrc \
    && echo 'export PATH="$DART_SDK/bin:$PATH"' >> $HOME/.bashrc

# install go
ENV GOLANG_VERSION 1.11.2
ENV GOLANG_DOWNLOAD_URL https://golang.org/dl/go$GOLANG_VERSION.linux-amd64.tar.gz
ENV GOPATH $HOME/go
RUN curl -fsSL "$GOLANG_DOWNLOAD_URL" -o golang.tar.gz \
	&& tar -C /usr/local -xzf golang.tar.gz \
	&& rm golang.tar.gz \
    && echo 'export GOROOT=/usr/local/go' >> $HOME/.bashrc \
    && echo 'export GOPATH=$HOME/go' >> $HOME/.bashrc \
    && echo 'export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH' >> $HOME/.bashrc \
    && mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"

# add bash tools
ADD ./tmux-session /usr/local/bin
# install vim plugins
ADD ./ycm_extra_conf.py $HOME/.ycm_extra_conf.py
ADD ./install_vim.sh /usr/local
ADD ./.vimrc $HOME/.vimrc
ADD ./.eslintrc.json $HOME/.eslintrc.json
ADD ./.tmux.conf $HOME/.tmux.conf
ADD ./.tmux.conf.local $HOME/.tmux.conf.local
ADD ./.inputrc $HOME/.inputrc
RUN chmod +x /usr/local/bin/tmux-session \
    && chmod +x /usr/local/install_vim.sh \
    && /usr/local/install_vim.sh


# Add none root user
# RUN  useradd geek && echo "geek:geek" | chpasswd && adduser geek sudo
# USER geek
# WORKDIR /home/geek
VOLUME [ "/data" ]
EXPOSE 22
WORKDIR /root
CMD /usr/sbin/sshd && bash
