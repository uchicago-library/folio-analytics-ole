# SQL

This directory is for the SQL files used to create derived tables from FOLIO data in the `public` schema.

## Conventions

### Dialect

The SQL will be of the Postgres variety, and will make heavy use of the JSON extensions.

### Table creation

Under LDP 1.0, tables are re-created nightly or more. Scripts should start with:
```
DROP TABLE IF EXISTS _tablename_;
```

## Rebuilding

For convenience, a simple shell script has been provided to rebuild
all the derived tables in the `local_ole` schema.

### Usage

```
rebuild.sh [-U <pg_user>] [-h <pg_host>] [-p <pg_port>] \
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
