#!/bin/bash

# Derive OLE compatibility tables from LDP tables

usage() {
    cat <<EOF >&2
Usage:
rebuild.sh [-U <pg_user>] [-h <pg_host>] [-p <pg_port>] \\
  -g <path to folio-analytics-ole repo working directory> \\
  [-b branch] [<pg_database>]

-g <path to folio-analytics-ole repo working directory> must be specified

Defaults:
   <pg_user>     : postgres
   <pg_host>     : localhost
   <pg_port>     : 5432
   <branch>      : main
   <pg_database> : postgres

For scripting, put user/host/port/database combination in .pgpass
EOF
}

while getopts ":U:h:p:g:b:" opt; do
    case ${opt} in
        U )
            user=$OPTARG
            ;;
        h )
            host=$OPTARG
            ;;
        p )
            port=$OPTARG
            ;;
        g )
            repo=$OPTARG
            ;;
        b )
            branch=$OPTARG
            ;;
        : )
            echo "$OPTARG requires an argument" >&2
            usage
            exit 1
            ;;
        \? )
            usage
            exit 1
            ;;
    esac
done
shift $((OPTIND -1))
database=$1

if test -z "$repo"; then
    usage
    exit 1
fi

psql_cmd="psql -a"
test ! -z "$host" && psql_cmd="$psql_cmd -h $host"
test ! -z "$port" && psql_cmd="$psql_cmd -p $port"
test ! -z "$user" && psql_cmd="$psql_cmd -U $user"

cd ${repo}/sql
git fetch origin

if [ "${branch}" ]; then
    git checkout ${branch}
else
    git checkout main
fi

git pull

for sql in "remove.sql" "add.sql" "load.sql" "grant.sql"; do
    "$psql_cmd -f $sql $database"
done
