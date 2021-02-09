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

