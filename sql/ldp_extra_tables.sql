/*
 * Extra derived tables for MS Access app queries, not originaly from OLE.
 * 
 * We are lazy about defining the columns...
 */

/*
 * marc_field_880
 * Only the 880 fields, supports non-Roman queries, e.g. in Pull List
 */
DROP TABLE local_ole.marctab_field_880;
CREATE TABLE local_ole.marctab_field_880 AS SELECT * FROM public.srs_marctab WHERE field = '880';
CREATE INDEX ON local_ole.marctab_field_880 (instance_hrid);
CREATE INDEX ON local_ole.marctab_field_880 (sf);
VACUUM ANALYZE local_ole.marctab_field_880;
