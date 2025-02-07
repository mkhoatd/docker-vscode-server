#!/bin/sh

exec code tunnel --tunnel-id="$TUNNEL_ID" --host-token="$TUNNEL_TOKEN" --name="$TUNNEL_NAME"
