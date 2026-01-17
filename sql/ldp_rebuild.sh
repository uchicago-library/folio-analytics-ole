#!/bin/bash

# Derive OLE compatibility tables from LDP tables

usage() {
    cat <<EOF >&2
Usage:
ldp_rebuild.sh [-U <pg_user>] [-h <pg_host>] [-p <pg_port>] \\
  -g <path to folio-analytics-ole repo working directory> \\
  [-b branch] \\
  [-r <role to grant access to local_ole schema and tables>] \\
  [<pg_database>]

-d <path to folio-analytics-ole repo working directory> must be specified

-r <role> can be repeated to grant access to multiple roles

<pg_user> must be able to create tables and grant access to the
local_ole schema

Defaults:
   <pg_user>     : postgres
   <pg_host>     : localhost
   <pg_port>     : 5432
   <branch>      : main
   <pg_database> : postgres

For scripting, put user/host/port/database combination in .pgpass
EOF
}

while getopts ":U:h:p:g:b:r:" opt; do
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
        r )
            if [ -z "$ole_role" ]; then
                ole_role=$OPTARG
            else
                ole_role="$ole_role $OPTARG"
            fi
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

for sql in "remove.sql" "add.sql" "ldp_load.sql" "ldp_extra_tables.sql"; do
    $psql_cmd -f $sql $database
done

for role in $ole_role; do
    $psql_cmd $database <<EOF
GRANT USAGE ON SCHEMA local_ole TO $role;
GRANT SELECT ON ALL TABLES IN SCHEMA local_ole TO $role;
EOF
done
