#!/bin/sh

. /env_secrets_expand.sh
mkdir -p ~/.pgweb/bookmarks
cat > ~/.pgweb/bookmarks/server.toml << EOF
url = "postgres://$POSTGRES_USER:$POSTGRES_PASSWORD@$POSTGRES_HOST:$POSTGRES_PORT/$POSTGRES_DB?sslmode=$POSTGRES_SSLMODE"
EOF
executable="/usr/bin/pgweb --bind=0.0.0.0 --listen=8081 --lock-session --bookmark=server"
if [[ $DEBUG ]]; then
    if $DEBUG; then
    executable="$executable --debug"
    fi
fi

if [[ $READONLY ]]; then
       executable="$executable --readonly"
fi
echo "$executable"
$executable
