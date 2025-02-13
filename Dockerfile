# kics-scan disable=67fd0c4a-68cf-46d7-8c41-bc9fba7e40ae,965a08d7-ef86-4f14-8792-4a3b2098937e

FROM ubuntu:24.04

# hadolint ignore=DL3008
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive && apt-get install -y --no-install-recommends \
  # tools & required packages
  git curl wget ca-certificates \
  # clean up
  && apt-get autoremove -y && apt-get clean -y && rm -rf /var/lib/apt/lists/*

ARG VERSION="1.96.4"
ENV TUNNEL_ID="tidy-book-tbx0m2m.asse"
ENV TUNNEL_TOKEN="eyJhbGciOiJFUzI1NiIsImtpZCI6IkZCM0U2NTMwNjlDQ0I5MUFCQUUxRTNFQjk1RDc5NzdERDQxODM1QjYiLCJ0eXAiOiJKV1QifQ.eyJjbHVzdGVySWQiOiJhc3NlIiwidHVubmVsSWQiOiJ0aWR5LWJvb2stdGJ4MG0ybSIsInNjcCI6ImNvbm5lY3QgbWFuYWdlIGhvc3QiLCJleHAiOjE3Mzg5ODE3NTMsImlzcyI6Imh0dHBzOi8vdHVubmVscy5hcGkudmlzdWFsc3R1ZGlvLmNvbS8iLCJuYmYiOjE3Mzg4OTQ0NTN9.1kjyDpEZT9okONEIQsxH3ERoL65T43mqmC8Mmr-i5vaolL2pU12OIn2mOfmrEaSz1eEB1rWtePPjPezag1ziPQ"
ENV TUNNEL_NAME="nosana"

# install visual studio code
RUN <<EOF
  ARCH="$(dpkg --print-architecture)";

  echo "ARCH: $ARCH";

  case "$ARCH" in
    amd64) export TARGET='cli-linux-x64' ;;
    arm64) export TARGET='cli-linux-arm64' ;;
  esac;

  wget -qO- https://update.code.visualstudio.com/${VERSION}/${TARGET}/stable | tar xvz -C /usr/bin/
  chmod +x /usr/bin/code
EOF

# entrypoint
# ENTRYPOINT [ "code", "serve-web", "--without-connection-token", "--accept-server-license-terms" ]

# default arguments
# CMD [ "--host", "0.0.0.0", "--port", "8000", "--cli-data-dir", "/root/.vscode/cli-data", "--user-data-dir", "/root/.vscode/user-data", "--server-data-dir", "/root/.vscode/server-data", "--extensions-dir", "/root/.vscode/extensions" ]

# ENTRYPOINT [ "code", "tunnel", "--accept-server-license-terms", "--tunnel-id", "${TUNNEL_ID}", "--host-token", "${TUNNEL_TOKEN}" ]
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["code", "tunnel", "--accept-server-license-terms" ]
CMD ["--tunnel-id", "${TUNNEL_ID}", "--host-token", "${TUNNEL_TOKEN}" "--name", "${TUNNEL_NAME}"]

HEALTHCHECK NONE

# expose port
EXPOSE 8000
