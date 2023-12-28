# SQL

This directory is for the SQL files used to create derived tables from
FOLIO data in a Metadb or LDP 1.X instance.

## Conventions

### LDP and Metadb

Versions for Metadb and LDP 1.X are prefixed `metadb_` and `ldp_`,
respectively. There are different "load" and "extra\_tables" SQL
scripts for Metadb and LDP 1.X, and the rebuild script likewise has
Metadb and LDP 1.X versions.

### Dialect

The SQL will be of the Postgres variety, and will make heavy use of
the JSON and JSONB extensions.

### Table creation

Tables should be re-created nightly or more. Scripts should start with:
```
DROP TABLE IF EXISTS _tablename_;
```

## Rebuilding

For convenience, a pair of simple shell scripts have been provided to
rebuild all the derived tables in the `local_ole` schema. The shell
script options are the same for Metadb and LDP 1.X.

### Usage

```
metadb_rebuild.sh [-U <pg_user>] [-h <pg_host>] [-p <pg_port>] \
  -g <path to folio-analytics-ole repo working directory> \
  [-b branch] \
  [-r <role to grant access to local_ole schema and tables>] \
  [<pg_database>]
```

`-g <path to folio-analytics-ole repo working directory>` must be specified

`-r <role>` can be repeated to grant access to multiple roles

`<pg_user>` must be able to create tables and grant access to the local_ole schema

Defaults:
* `<pg_user>`     : `postgres`
* `<pg_host>`     : `localhost`
* `<pg_port>`     : `5432`
* `<branch>`      : `main`
* `<pg_database>` : `postgres`

For scripting, put user/host/port/database combination in .pgpass
