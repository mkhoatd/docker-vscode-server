# VS Code Server Docker Image

a Docker image for VS Code Server

[![license][license-img]][license-url]
[![release][release-img]][release-url]
[![size][size-img]][size-url]
[![docker][docker-img]][docker-url]
[![github][github-img]][github-url]

This is simply a containerized version of the VS Code Server.

## Features

<!-- markdownlint-capture -->

<!-- markdownlint-disable MD007 MD030 -->

- Runs entirely locally, without needing `vscode.dev`
- Persistent secrets *(requirement for Settings Sync)*

<!-- markdownlint-restore -->

## Usage

``` bash
docker run --rm \
  --name vscode-server \
  --hostname vscode \
  -p 8000:8000 \
  -v ./server-data:/root/.vscode/server-data \
  -v ./user-data:/root/.vscode/user-data \
  -v ./cli-data:/root/.vscode/cli-data \
  -v ./extensions:/root/.vscode/extensions \
  mkhoatd/vscode-server:latest
```

[license-url]: LICENSE
[license-img]: https://badgen.net/github/license/mkhoatd/docker-vscode-server

[release-url]: https://github.com/mkhoatd/docker-vscode-server/releases
[release-img]: https://badgen.net/github/release/mkhoatd/docker-vscode-server

[size-url]: https://hub.docker.com/r/mkhoatd/docker-vscode-server
[size-img]: https://badgen.net/docker/size/mkhoatd/docker-vscode-server?label=image%20size

[docker-url]: https://hub.docker.com/r/mkhoatd/docker-vscode-server
[docker-img]: https://badgen.net/badge/icon/docker%20hub?icon=docker&label

[github-url]: https://github.com/mkhoatd/docker-vscode-server/pkgs/container/docker-vscode-server
[github-img]: https://badgen.net/badge/icon/github%20registry?icon=github&label
