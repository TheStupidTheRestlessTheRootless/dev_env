# dev_env_dockerfile

based on ubuntu18.04

# base

[Dockerfile](./Dockerfile)

# run

> docker run -it -d -v localFolder:/data -p 8654:22 base:5.0

- [x] ssh (apt)
- [x] node: 8.11.2
- [x] python: 3.7.0
- [x] java: 8
- [ ] go: 1.11.1
- [ ] dart: 2.0.0
- [ ] flutter: 0.10.1
- [ ] nginx: 1.15.5
- [x] git: 2.19.0
- [x] vim + plugins
- [x] tmux 2.5(cronb tmux-session)
- [x] [nvm](https://github.com/creationix/nvm)
- [x] [pyenv](https://github.com/pyenv/pyenv)