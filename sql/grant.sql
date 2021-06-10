/*
 * Grant access to local_ole tables to uchicago_ole role
 * This will fail if role do not exist
 * Must be run as schema owner
*/

GRANT USAGE ON local_ole TO uchicago_ole;
GRANT SELECT ON ALL TABLES IN SCHEMA local_ole TO uchicago_ole;
