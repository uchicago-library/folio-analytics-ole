/*
 * Functions to convert FOLIO UUIDs to OLE IDs, both as VARCHAR AND INT
 */
DROP FUNCTION IF EXISTS local_ole.uuid_to_ole_id_str;
CREATE OR REPLACE FUNCTION local_ole.uuid_to_ole_id_str(hexval varchar) RETURNS varchar(40) AS $$
DECLARE
   result   varchar(40);
BEGIN
 EXECUTE 'SELECT x''' || substring(hexval FOR 8) || '''::int::text' INTO result;
 RETURN result;
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;

DROP FUNCTION IF EXISTS local_ole.uuid_to_ole_id_int;
CREATE OR REPLACE FUNCTION local_ole.uuid_to_ole_id_int(hexval varchar) RETURNS integer AS $$
DECLARE
   result   integer;
BEGIN
 EXECUTE 'SELECT x''' || substring(hexval FOR 8) || '''::int' INTO result;
 RETURN result;
END;
$$
LANGUAGE 'plpgsql' IMMUTABLE STRICT;


/*Country*/
TRUNCATE TABLE local_ole.krlc_cntry_t CASCADE;
INSERT INTO local_ole.krlc_cntry_t
SELECT
alpha2_code AS postal_cntry_cd,
md5(alpha2_code) AS obj_id,
1.0 AS ver_nbr,
name AS postal_cntry_nm,
'N' AS pstl_cntry_rstrc_ind,
'Y' AS actv_ind,
alpha3_code AS alt_postal_cntry_cd
FROM local_ole.uc_countries;

/*State*/
TRUNCATE TABLE local_ole.krlc_st_t CASCADE;
INSERT INTO local_ole.krlc_st_t
SELECT
NULL AS postal_state_cd,
NULL AS postal_cntry_cd,
NULL AS obj_id,
1.0 AS ver_nbr,
NULL AS postal_state_nm,
NULL AS actv_ind
LIMIT 0;

/*PostalCode*/
TRUNCATE TABLE local_ole.krlc_pstl_cd_t CASCADE;
INSERT INTO local_ole.krlc_pstl_cd_t
SELECT
NULL AS postal_cd,
NULL AS county_cd,
NULL AS obj_id,
NULL AS postal_state_cd,
NULL AS postal_cntry_cd,
1.0 AS ver_nbr,
NULL AS postal_city_nm,
NULL AS actv_ind
LIMIT 0;

/*Rule*/
TRUNCATE TABLE local_ole.krms_rule_t CASCADE;
INSERT INTO local_ole.krms_rule_t
SELECT
NULL AS rule_id,
NULL AS nmspc_cd,
NULL AS nm,
NULL AS typ_id,
NULL AS prop_id,
NULL AS actv,
1.0 AS ver_nbr,
NULL AS desc_txt
LIMIT 0;

/*Role*/
TRUNCATE TABLE local_ole.krim_role_t CASCADE;
INSERT INTO local_ole.krim_role_t
SELECT
NULL AS role_id,
NULL AS obj_id,
1.0 AS ver_nbr,
NULL AS role_nm,
NULL AS nmspc_cd,
NULL AS desc_txt,
NULL AS kim_typ_id,
NULL AS actv_ind,
NULL AS last_updt_dt
LIMIT 0;

/*RolePermission*/
TRUNCATE TABLE local_ole.krim_role_perm_t CASCADE;
INSERT INTO local_ole.krim_role_perm_t
SELECT
NULL AS role_perm_id,
NULL AS obj_id,
1.0 AS ver_nbr,
NULL AS role_id,
NULL AS perm_id,
NULL AS actv_ind
LIMIT 0;

/*Source*/
TRUNCATE TABLE local_ole.ole_dlvr_src_t CASCADE;
INSERT INTO local_ole.ole_dlvr_src_t
SELECT
'9e58b46a-1ba9-430f-8373-0a343231aaf0' AS ole_dlvr_src_id,
'CNTD' AS ole_dlvr_src_cd,
'University' AS ole_dlvr_src_desc,
'University' AS ole_dlvr_src_nm,
'9e58b46a-1ba9-430f-8373-0a343231aaf0' AS obj_id,
1.0 AS ver_nbr,
'Y' AS row_act_ind
UNION
SELECT
'6306ab00-04d3-41ce-8691-25ccda4daff5' AS ole_dlvr_src_id,
'LIB' AS ole_dlvr_src_cd,
'Library' AS ole_dlvr_src_desc,
'Library' AS ole_dlvr_src_nm,
'6306ab00-04d3-41ce-8691-25ccda4daff5' AS obj_id,
1.0 AS ver_nbr,
'Y' AS row_act_ind;

/*PatronType*/
TRUNCATE TABLE local_ole.ole_dlvr_borr_typ_t CASCADE;
INSERT INTO local_ole.ole_dlvr_borr_typ_t
SELECT
id AS dlvr_borr_typ_id,
jsonb_extract_path_text(jsonb,'desc') AS dlvr_borr_typ_cd,
jsonb_extract_path_text(jsonb,'group') AS dlvr_borr_typ_desc,
jsonb_extract_path_text(jsonb,'group') AS dlvr_borr_typ_nm,
id AS obj_id,
1.0 AS ver_nbr,
'Y' AS row_act_ind
FROM folio_users.groups;

/*PatronCategory*/
TRUNCATE TABLE local_ole.ole_dlvr_stat_cat_t CASCADE;
INSERT INTO local_ole.ole_dlvr_stat_cat_t
SELECT
md5(code) AS ole_dlvr_stat_cat_id,
code AS ole_dlvr_stat_cat_cd,
code AS ole_dlvr_stat_cat_desc,
code AS ole_dlvr_stat_cat_nm,
md5(code) AS obj_id,
1.0 AS ver_nbr,
'Y' AS row_act_ind
FROM
(
SELECT
jsonb_extract_path_text(jsonb,'customFields','category') AS code
FROM folio_users.users
WHERE jsonb_extract_path_text(jsonb,'customFields','category') IS NOT NULL
GROUP BY jsonb_extract_path_text(jsonb,'customFields','category')
) a;

/*PatronNoteType*/
TRUNCATE TABLE local_ole.ole_ptrn_nte_typ_t CASCADE;
INSERT INTO local_ole.ole_ptrn_nte_typ_t
SELECT
NULL AS ole_ptrn_nte_typ_id,
NULL AS ole_ptrn_nte_typ_nm,
NULL AS ole_ptrn_nte_type_cd,
NULL AS obj_id,
NULL AS actv_ind
LIMIT 0;

/*Person*/
TRUNCATE TABLE local_ole.krim_entity_t CASCADE;
INSERT INTO local_ole.krim_entity_t
SELECT
id AS entity_id,
id AS obj_id,
1.0 AS ver_nbr,
CASE WHEN (jsonb_extract_path_text(jsonb,'active'))::boolean THEN 'Y' ELSE 'N' END AS actv_ind,
(jsonb_extract_path_text(jsonb,'metadata','updatedDate'))::timestamp with time zone AS last_updt_dt
FROM folio_users.users;

/*Name*/
TRUNCATE TABLE local_ole.krim_entity_nm_t CASCADE;
INSERT INTO local_ole.krim_entity_nm_t
SELECT
id AS entity_nm_id,
id AS obj_id,
1.0 AS ver_nbr,
id AS entity_id,
NULL AS nm_typ_cd,
jsonb_extract_path_text(jsonb,'personal','firstName') AS first_nm,
jsonb_extract_path_text(jsonb,'personal','middleName') AS middle_nm,
jsonb_extract_path_text(jsonb,'personal','lastName') AS last_nm,
NULL AS suffix_nm,
NULL AS prefix_nm,
'Y' AS dflt_ind,
'Y' AS actv_ind,
(jsonb_extract_path_text(jsonb,'metadata','updatedDate'))::timestamp with time zone AS last_updt_dt,
NULL AS title_nm,
NULL AS note_msg,
NULL AS nm_chng_dt
FROM folio_users.users;

/*PhoneNumber*/
TRUNCATE TABLE local_ole.krim_entity_phone_t CASCADE;
INSERT INTO local_ole.krim_entity_phone_t
SELECT
md5(id || 'HOME' || (jsonb_extract_path_text(jsonb,'personal','phone'))) AS entity_phone_id,
md5(id || 'HOME' || (jsonb_extract_path_text(jsonb,'personal','phone'))) AS obj_id,
1.0 AS ver_nbr,
'PERSON' AS ent_typ_cd,
id AS entity_id,
'HOME' AS phone_typ_cd,
jsonb_extract_path_text(jsonb,'personal','phone') AS phone_nbr,
NULL AS phone_extn_nbr,
NULL AS postal_cntry_cd,
NULL AS dflt_ind,
'Y' AS actv_ind,
(jsonb_extract_path_text(jsonb,'metadata','updatedDate'))::timestamp with time zone AS last_updt_dt
FROM folio_users.users
WHERE jsonb_extract_path_text(jsonb,'personal','phone') IS NOT NULL
UNION
SELECT
md5(id || 'MOBILE' || (jsonb_extract_path_text(jsonb,'personal','mobilePhone'))) AS entity_phone_id,
md5(id || 'MOBILE' || (jsonb_extract_path_text(jsonb,'personal','mobilePhone'))) AS obj_id,
1.0 AS ver_nbr,
'PERSON' AS ent_typ_cd,
id AS entity_id,
'MOBILE' AS phone_typ_cd,
jsonb_extract_path_text(jsonb,'personal','mobilePhone') AS phone_nbr,
NULL AS phone_extn_nbr,
NULL AS postal_cntry_cd,
NULL AS dflt_ind,
'Y' AS actv_ind,
(jsonb_extract_path_text(jsonb,'metadata','updatedDate'))::timestamp with time zone AS last_updt_dt
FROM folio_users.users
WHERE jsonb_extract_path_text(jsonb,'personal','mobilePhone') IS NOT NULL ;

/*EmailAddress*/
TRUNCATE TABLE local_ole.krim_entity_email_t CASCADE;
INSERT INTO local_ole.krim_entity_email_t
SELECT
id AS entity_email_id,
id AS obj_id,
1.0 AS ver_nbr,
'PERSON' AS ent_typ_cd,
id AS entity_id,
CASE WHEN jsonb_extract_path_text(jsonb,'personal','email') LIKE '%uchicago.edu' OR jsonb_extract_path_text(jsonb,'personal','email') LIKE '%uchospitals.edu' THEN 'CMP' ELSE 'HM' END AS email_typ_cd,
jsonb_extract_path_text(jsonb,'personal','email') AS email_addr,
'Y' AS dflt_ind,
'Y' AS actv_ind,
(jsonb_extract_path_text(jsonb,'metadata','updatedDate'))::timestamp with time zone AS last_updt_dt
FROM folio_users.users;

/*Address*/
TRUNCATE TABLE local_ole.krim_entity_addr_t CASCADE;
INSERT INTO local_ole.krim_entity_addr_t
SELECT
md5(id || coalesce(jsonb_extract_path_text(a.jsonb,'addressTypeId'),'') || coalesce(jsonb_extract_path_text(a.jsonb,'addressLine1'),'')) AS entity_addr_id,
md5(id || coalesce(jsonb_extract_path_text(a.jsonb,'addressTypeId'),'') || coalesce(jsonb_extract_path_text(a.jsonb,'addressLine1'),'')) AS obj_id,
1.0 AS ver_nbr,
'PERSON' AS ent_typ_cd,
u.id AS entity_id,
jsonb_extract_path_text(a.jsonb,'addressTypeId') AS addr_typ_cd,
jsonb_extract_path_text(a.jsonb,'addressLine1') AS addr_line_1,
jsonb_extract_path_text(a.jsonb,'addressLine2') AS addr_line_2,
NULL AS addr_line_3,
jsonb_extract_path_text(a.jsonb,'city') AS city,
(jsonb_extract_path_text(a.jsonb,'region'))::varchar(2) AS state_pvc_cd,
jsonb_extract_path_text(a.jsonb,'postalCode') AS postal_cd,
jsonb_extract_path_text(a.jsonb,'countryId') AS postal_cntry_cd,
/* FOLIO had a primary address, not a default. Few notices delivered by mail now */
NULL AS dflt_ind,
'Y' AS actv_ind,
(jsonb_extract_path_text(u.jsonb,'metadata','updatedDate'))::timestamp with time zone AS last_updt_dt,
NULL AS attn_line,
NULL AS addr_fmt,
NULL AS mod_dt,
NULL AS valid_dt,
'Y' AS valid_ind,
NULL AS note_msg
FROM folio_users.users AS u, jsonb_array_elements(jsonb_extract_path(u.jsonb,'personal','addresses')) AS a;

/*Affiliation*/
TRUNCATE TABLE local_ole.krim_entity_afltn_t CASCADE;
INSERT INTO local_ole.krim_entity_afltn_t
SELECT
NULL AS entity_afltn_id,
NULL AS obj_id,
1.0 AS ver_nbr,
NULL AS entity_id,
NULL AS afltn_typ_cd,
NULL AS campus_cd,
NULL AS dflt_ind,
NULL AS actv_ind,
NULL AS last_updt_dt
LIMIT 0;

/*Employment*/
TRUNCATE TABLE local_ole.krim_entity_emp_info_t CASCADE;
INSERT INTO local_ole.krim_entity_emp_info_t
SELECT
NULL AS entity_emp_id,
NULL AS obj_id,
1.0 AS ver_nbr,
NULL AS entity_id,
NULL AS entity_afltn_id,
NULL AS emp_stat_cd,
NULL AS emp_typ_cd,
NULL AS base_slry_amt,
NULL AS prmry_ind,
NULL AS actv_ind,
NULL AS last_updt_dt,
NULL AS prmry_dept_cd,
NULL AS emp_id,
NULL AS emp_rec_id
LIMIT 0;

/*Patron*/
TRUNCATE TABLE local_ole.ole_ptrn_t CASCADE;
INSERT INTO local_ole.ole_ptrn_t
SELECT
id AS ole_ptrn_id,
id AS obj_id,
1.0 AS ver_nbr,
jsonb_extract_path_text(jsonb,'barcode') AS barcode,
CASE WHEN jsonb_extract_path_text(jsonb,'patronGroup') IS NOT NULL THEN jsonb_extract_path_text(jsonb,'patronGroup') ELSE '06f2d60e-0b07-49ca-b8c7-e1d49808e0b7' END AS borr_typ,
CASE WHEN (jsonb_extract_path_text(jsonb,'active'))::boolean THEN 'Y' ELSE 'N' END AS actv_ind,
NULL AS general_block,
NULL AS paging_privilege,
NULL AS courtesy_notice,
NULL AS delivery_privilege,
(jsonb_extract_path_text(jsonb,'expirationDate'))::timestamp with time zone AS expiration_date,
(jsonb_extract_path_text(jsonb,'enrollmentDate'))::timestamp with time zone AS activation_date,
NULL AS general_block_nt,
NULL AS inv_barcode_num,
NULL AS inv_barcode_num_eff_date,
CASE jsonb_extract_path_text(jsonb,'customFields','source')
WHEN 'University' THEN '9e58b46a-1ba9-430f-8373-0a343231aaf0'
WHEN 'Library' THEN '6306ab00-04d3-41ce-8691-25ccda4daff5'
ELSE NULL END AS ole_src,
md5(jsonb_extract_path_text(jsonb,'customFields','category')) AS ole_stat_cat,
NULL AS photograph
FROM folio_users.users;

/*PatronId1*/
TRUNCATE TABLE local_ole.ole_ptrn_local_id_t CASCADE;
INSERT INTO local_ole.ole_ptrn_local_id_t
SELECT
id AS ole_ptrn_local_seq_id,
id AS obj_id,
1.0 AS ver_nbr,
id AS ole_ptrn_id,
jsonb_extract_path_text(jsonb,'externalSystemId') AS local_id
FROM folio_users.users
WHERE jsonb_extract_path_text(jsonb,'externalSystemId') IS NOT NULL;

/*PatronAddress*/
TRUNCATE TABLE local_ole.ole_dlvr_add_t CASCADE;
INSERT INTO local_ole.ole_dlvr_add_t
SELECT
entity_addr_id AS dlvr_add_id,
entity_addr_id AS obj_id,
1.0 AS ver_nbr,
entity_id AS ole_ptrn_id,
entity_addr_id AS entity_addr_id,
'Y' AS dlvr_ptrn_add_ver,
NULL AS add_valid_from,
NULL AS add_valid_to,
p.ole_src AS ole_addr_src,
NULL AS ptrn_dlvr_add
FROM local_ole.krim_entity_addr_t a
JOIN local_ole.ole_ptrn_t p ON p.ole_ptrn_id = a.entity_id;

/*PatronNote*/
TRUNCATE TABLE local_ole.ole_ptrn_nte_t CASCADE;
INSERT INTO local_ole.ole_ptrn_nte_t
SELECT
NULL AS ole_ptrn_nte_id,
NULL AS obj_id,
1.0 AS ver_nbr,
NULL AS ole_ptrn_id,
NULL AS ole_ptrn_nte_typ_id,
NULL AS ole_ptrn_nte_txt,
NULL AS actv_ind,
NULL AS optr_id,
NULL AS nte_crt_or_updt_date
LIMIT 0;

/*PersonExt*/
TRUNCATE TABLE local_ole.uc_entity_ext CASCADE;
INSERT INTO local_ole.uc_entity_ext
SELECT
u.id AS id,
(jsonb_extract_path_text(u.jsonb,'customFields','studentId'))::int AS student_id,
CASE WHEN CHAR_LENGTH(jsonb_extract_path_text(u.jsonb,'externalSystemId')) = 9 THEN jsonb_extract_path_text(u.jsonb,'externalSystemId') ELSE NULL END AS chicago_id,
jsonb_extract_path_text(u.jsonb,'customFields','staffDivision') AS staff_division,
jsonb_extract_path_text(u.jsonb,'customFields','staffDepartment') AS staff_department,
jsonb_extract_path_text(u.jsonb,'customFields','studentDivision') AS student_division,
jsonb_extract_path_text(u.jsonb,'customFields','studentDepartment') AS student_department,
jsonb_extract_path_text(u.jsonb,'customFields','status') AS status,
jsonb_extract_path_text(u.jsonb,'customFields','statuses') AS statuses,
jsonb_extract_path_text(u.jsonb,'customFields','staffStatus') AS staff_status,
jsonb_extract_path_text(u.jsonb,'customFields','studentStatus') AS student_status,
jsonb_extract_path_text(u.jsonb,'customFields','studentRestriction')::boolean AS student_restriction,
jsonb_extract_path_text(u.jsonb,'customFields','staffPrivileges') AS staff_privileges,
COALESCE((jsonb_extract_path_text(u.jsonb,'customFields','deceased'))::boolean, false) AS deceased,
COALESCE((jsonb_extract_path_text(u.jsonb,'customFields','collections'))::boolean, false) AS collections,
(jsonb_extract_path_text(u.jsonb,'metadata','createdDate'))::timestamp with time zone AS creation_time,
jsonb_extract_path_text(u2.jsonb,'username') AS creation_user_name,
(jsonb_extract_path_text(u.jsonb,'metadata','updatedDate'))::timestamp with time zone AS last_write_time,
jsonb_extract_path_text(u3.jsonb,'username') AS last_write_user_name
FROM folio_users.users AS u
LEFT JOIN folio_users.groups AS g ON g.id = jsonb_extract_path_text(u.jsonb,'patronGroup')::uuid
LEFT JOIN folio_users.users AS u2 ON u2.id = jsonb_extract_path_text(u.jsonb,'metadata','createdByUserId')::uuid
LEFT JOIN folio_users.users AS u3 ON u3.id = jsonb_extract_path_text(u.jsonb,'metadata','updatedByUserId')::uuid;

/*Proxy patrons*/
TRUNCATE TABLE local_ole.ole_proxy_ptrn_t CASCADE;
INSERT INTO local_ole.ole_proxy_ptrn_t
SELECT
    id AS ole_proxy_ptrn_id,
    id AS obj_id,
    1 AS ver_nbr,
    jsonb_extract_path_text(jsonb,'userId') AS ole_ptrn_id,
    jsonb_extract_path_text(jsonb,'proxyUserId') AS ole_proxy_ptrn_ref_id,
    jsonb_extract_path_text(jsonb,'expirationDate')::timestamp AS ole_proxy_ptrn_exp_dt,
    jsonb_extract_path_text(jsonb,'metadata','createdDate')::timestamp AS ole_proxy_ptrn_act_dt,
    CASE WHEN (jsonb_extract_path_text(jsonb,'status') = 'Active') THEN 'Y' ELSE 'N' END AS actv_ind
FROM folio_users.proxyfor;

/*User*/
TRUNCATE TABLE local_ole.krim_prncpl_t CASCADE;
INSERT INTO local_ole.krim_prncpl_t
SELECT
id AS prncpl_id,
id AS obj_id,
1.0 AS ver_nbr,
jsonb_extract_path_text(jsonb,'username') AS prncpl_nm,
id AS entity_id,
NULL AS prncpl_pswd,
CASE WHEN (jsonb_extract_path_text(jsonb,'active'))::boolean THEN 'Y' ELSE 'N' END AS actv_ind,
(jsonb_extract_path_text(jsonb,'metadata','updatedDate'))::timestamp with time zone AS last_updt_dt
FROM folio_users.users
WHERE jsonb_extract_path_text(jsonb,'username') IS NOT NULL;

/*UserRole*/
TRUNCATE TABLE local_ole.krim_role_mbr_t CASCADE;
INSERT INTO local_ole.krim_role_mbr_t
SELECT
NULL AS role_mbr_id,
1.0 AS ver_nbr,
NULL AS obj_id,
NULL AS role_id,
NULL AS mbr_id,
NULL AS mbr_typ_cd,
NULL AS actv_frm_dt,
NULL AS actv_to_dt,
NULL AS last_updt_dt
LIMIT 0;

/*CallNumberType*/
TRUNCATE TABLE local_ole.ole_cat_shvlg_schm_t CASCADE;
INSERT INTO local_ole.ole_cat_shvlg_schm_t
SELECT
    id::uuid AS shvlg_schm_id,
    id AS obj_id,
    1.0 AS ver_nbr,
    substring(jsonb_extract_path_text(jsonb,'name') FOR 40) AS shvlg_schm_cd,
    jsonb_extract_path_text(jsonb,'name') AS shvlg_schm_nm,
    jsonb_extract_path_text(jsonb,'source') AS src,
    '2012-03-22 00:00:00.0'::timestamp AS src_dt,
    'Y' AS row_act_ind,
    NULL AS date_updated
FROM folio_inventory.call_number_type;

/*ItemStatus*/
/*
 * Pull List only needs to display status labels.
 * Strategy is to create this table based on the hard-coded values.
 * The ID for referring tables then can always be computed from the text value of the status of the item.
 *
 * Note: item status id is defined as VARCHAR(40) but referenced as INT, so
 * we created an MD5 checksum, then use the same trick as for UUIDs.
 */
TRUNCATE TABLE local_ole.ole_dlvr_item_avail_stat_t CASCADE;
WITH item_stats(stat) AS (
    VALUES
        ('Available'),
        ('Awaiting pickup'),
        ('Awaiting delivery'),
        ('Checked out'),
        ('Claimed returned'),
        ('Declared lost'),
        ('In process'),
        ('In process (non-requestable)'),
        ('In transit'),
        ('Intellectual item'),
        ('Long missing'),
        ('Lost and paid'),
        ('Missing'),
        ('On order'),
        ('Paged'),
        ('Restricted'),
        ('Order closed'),
        ('Unavailable'),
        ('Unknown'),
        ('Withdrawn')
)
INSERT INTO local_ole.ole_dlvr_item_avail_stat_t
SELECT
    md5(stat) AS item_avail_stat_id,
    stat AS obj_id,
    1.0 AS ver_nbr,
    stat AS item_avail_stat_cd,
    stat AS item_avail_stat_nm,
    'Y' AS row_act_ind,
    NULL AS date_updated
FROM item_stats;

/*ItemType1*/
TRUNCATE TABLE local_ole.ole_cat_itm_typ_t CASCADE;
/*
 * Use first four bytes of UUID to generate an integer item type ID
 */
INSERT INTO local_ole.ole_cat_itm_typ_t
SELECT
  loan_types.id AS itm_typ_cd_id,
  jsonb_extract_path_text(loan_types.jsonb,'name') AS itm_typ_cd,
  jsonb_extract_path_text(loan_types.jsonb,'name') AS itm_typ_nm,
  NULL AS itm_typ_desc,
  '' AS src,
  NULL AS src_dt,
  '' AS row_act_ind,
  loan_types.id AS obj_id,
  1.0 AS ver_nbr,
  (jsonb_extract_path_text(loan_types.jsonb,'metadata','updatedDate'))::timestamp with time zone AS date_updated
FROM folio_inventory.loan_type AS loan_types;

/*Location*/
TRUNCATE TABLE local_ole.ole_locn_t CASCADE;
INSERT INTO local_ole.ole_locn_t
SELECT
    local_ole.uuid_to_ole_id_str(id::varchar) AS locn_id,
    id AS obj_id,
    1.0 AS ver_nbr,
    replace(jsonb_extract_path_text(jsonb,'code'), 'UC/HP/', 'UC/') AS locn_cd,
    jsonb_extract_path_text(jsonb,'name') AS locn_name,
    '5' AS level_id,
    NULL AS parent_locn_id,
    CASE WHEN jsonb_extract_path_text(jsonb,'isActive')::boolean THEN 'Y' ELSE 'N' END AS row_act_ind
FROM folio_inventory.location;

/*Bib*/
/* ~17 minutes */
TRUNCATE TABLE local_ole.ole_ds_bib_t CASCADE;
INSERT INTO local_ole.ole_ds_bib_t
SELECT
CAST( jsonb_extract_path_text(ii.jsonb,'hrid') AS integer ) AS bib_id,
NULL AS former_id,
NULL AS fast_add,
(CASE WHEN jsonb_extract_path_text(ii.jsonb,'discoverySuppress')::boolean THEN 'Y' ELSE 'N' END) AS staff_only,
jsonb_extract_path_text(ii.jsonb,'metadata','createdByUsername') AS created_by,
(jsonb_extract_path_text(ii.jsonb,'metadata','createdDate'))::timestamp with time zone AS date_created,
jsonb_extract_path_text(ii.jsonb,'metadata','updatedByUsername') AS updated_by,
(jsonb_extract_path_text(ii.jsonb,'metadata','updatedDate'))::timestamp with time zone AS date_updated,
jsonb_extract_path_text(iis.jsonb,'name') AS status,
NULL AS status_updated_by,
jsonb_extract_path_text(ii.jsonb,'statusUpdatedDate') AS status_updated_date,
NULL AS unique_id_prefix,
NULL AS CONTENT
FROM folio_inventory.instance AS ii
LEFT JOIN folio_inventory.instance_status AS iis ON iis.id = jsonb_extract_path_text(ii.jsonb,'statusId')::uuid;

/*BibInfo*/
/* ~15 minutes */
TRUNCATE TABLE local_ole.ole_ds_bib_info_t CASCADE;
INSERT INTO local_ole.ole_ds_bib_info_t
SELECT
    'wbm-'||(jsonb_extract_path_text(jsonb,'hrid')) AS bib_id_str, /* using OLE nomenclature, could use UUIDs */
    jsonb_extract_path_text(jsonb,'hrid')::int AS bib_id,
    jsonb_extract_path_text(jsonb,'title') AS title,
    jsonb_extract_path_text(jsonb,'contributors','0','name') AS author,
    jsonb_extract_path_text(jsonb,'publication','0','publisher') AS publisher,
    NULL AS isxn,
    (jsonb_extract_path_text(jsonb,'metadata','updatedDate'))::timestamp AS date_updated
FROM folio_inventory.instance;

/*Holding*/
/* ~10 minutes */
TRUNCATE TABLE local_ole.ole_ds_holdings_t CASCADE;
INSERT INTO local_ole.ole_ds_holdings_t
SELECT
	jsonb_extract_path_text(holdings.jsonb,'hrid')::int AS holdings_id,
	jsonb_extract_path_text(instance.jsonb,'hrid')::int AS bib_id,
	jsonb_extract_path_text(holdings_type.jsonb,'name') AS holdings_type,
	NULL AS former_holdings_id,
	(CASE WHEN jsonb_extract_path_text(holdings.jsonb,'discoverySuppress')::boolean THEN 'Y' ELSE 'N' END) AS staff_only,
	NULL AS location_id,
	jsonb_extract_path_text(holdings_permanent_location.jsonb,'code') AS location,
	NULL AS location_level,
   	jsonb_extract_path_text(holdings.jsonb,'callNumberTypeId')::uuid AS call_number_type_id,
	jsonb_extract_path_text(holdings.jsonb,'callNumberPrefix') AS call_number_prefix,
	jsonb_extract_path_text(holdings.jsonb,'callNumber') AS call_number,
	NULL AS shelving_order,
	CASE WHEN char_length(jsonb_extract_path_text(holdings.jsonb,'copyNumber')) > 20
		THEN substring(jsonb_extract_path_text(holdings.jsonb,'copyNumber') FOR 20)
		ELSE jsonb_extract_path_text(holdings.jsonb,'copyNumber')
	END AS copy_number,
	NULL AS receipt_status_id,
	NULL AS publisher,
	NULL AS access_status,
	NULL AS access_status_date_updated,
	NULL AS subscription_status,
	NULL AS platform,
	NULL AS imprint,
	NULL AS local_persistent_uri,
	NULL AS allow_ill,
	NULL AS authentication_type_id,
	NULL AS proxied_resource,
	NULL AS number_simult_users,
	NULL AS e_resource_id,
	NULL AS admin_url,
	NULL AS admin_username,
	NULL AS admin_password,
	NULL AS access_username,
	NULL AS access_password,
	NULL AS unique_id_prefix,
	NULL AS source_holdings_content,
	NULL AS initial_sbrcptn_start_dt,
	NULL AS current_sbrcptn_start_dt,
	NULL AS current_sbrcptn_end_dt,
	NULL AS cancellation_decision_dt,
	NULL AS cancellation_effective_dt,
	NULL AS cancellation_reason,
	NULL AS gokb_identifier,
	NULL AS cancellation_candidate,
	NULL AS materials_specified,
	NULL AS first_indicator,
	NULL AS second_indicator,
	jsonb_extract_path_text(holdings.jsonb,'metadata','createdByUsername') AS created_by,
	jsonb_extract_path_text(holdings.jsonb,'metadata','createdDate')::timestamp with time zone AS date_created,
	jsonb_extract_path_text(holdings.jsonb,'metadata','updatedByUsername') AS updated_by,
	jsonb_extract_path_text(holdings.jsonb,'metadata','updatedDate')::timestamp with time zone AS date_updated
FROM
	folio_inventory.holdings_record AS holdings
	JOIN folio_inventory.instance AS instance ON instance.id = jsonb_extract_path_text(holdings.jsonb,'instanceId')::uuid
	LEFT JOIN folio_inventory.holdings_type AS holdings_type ON jsonb_extract_path_text(holdings.jsonb,'holdingsTypeId')::uuid = holdings_type.id
	LEFT JOIN folio_inventory.location AS holdings_permanent_location ON jsonb_extract_path_text(holdings.jsonb,'permanentLocationId')::uuid = holdings_permanent_location.id;

/*HoldingNote*/
/* ~1.5 min. */
TRUNCATE TABLE local_ole.ole_ds_holdings_note_t CASCADE;
INSERT INTO local_ole.ole_ds_holdings_note_t
SELECT
    /* need multiply by 100, multiply by 10 results in non-unique key */
    (jsonb_extract_path_text(holdings.jsonb,'hrid')::int * 100) + notes.ORDINALITY AS holdings_note_id,
    CAST(jsonb_extract_path_text(holdings.jsonb,'hrid') AS integer ) AS holdings_id,
    CASE WHEN (jsonb_extract_path_text(notes.jsonb,'staffOnly'))::boolean
        THEN 'nonPublic'
        ELSE 'Public'
    END AS type,
    jsonb_extract_path_text(notes.jsonb,'note') AS note,
    NULL AS date_updated
FROM
    folio_inventory.holdings_record AS holdings
    CROSS JOIN jsonb_array_elements(jsonb_extract_path(jsonb,'notes')) WITH ORDINALITY AS notes(jsonb);

/*Item*/
/* ~15 minutes */
TRUNCATE TABLE local_ole.ole_ds_item_t CASCADE;
INSERT INTO local_ole.ole_ds_item_t
SELECT
    jsonb_extract_path_text(items.jsonb,'hrid')::int AS item_id,
    jsonb_extract_path_text(holdings.jsonb,'hrid')::int AS holdings_id,
    jsonb_extract_path_text(items.jsonb,'barcode') AS barcode,
    NULL AS fast_add,
    (CASE WHEN jsonb_extract_path_text(items.jsonb,'discoverySuppress')::boolean THEN 'Y' ELSE 'N' END) AS staff_only,
    NULL AS uri,
    items.permanentloantypeid AS item_type_id,
    items.temporaryloantypeid AS temp_item_type_id,
    md5(jsonb_extract_path_text(items.jsonb,'status','name')) AS item_status_id,
    jsonb_extract_path_text(items.jsonb,'status','date')::timestamp AS item_status_date_updated,
    local_ole.uuid_to_ole_id_int(items.permanentlocationid::varchar) AS location_id,
    jsonb_extract_path_text(locations.jsonb,'code') AS location,
    NULL AS location_level,
    callnumbertypeid::uuid AS call_number_type_id,
    jsonb_extract_path_text(items.jsonb,'itemLevelCallNumberPrefix') AS call_number_prefix,
    jsonb_extract_path_text(items.jsonb,'itemLevelCallNumber') AS call_number,
    jsonb_extract_path_text(items.jsonb,'effectiveShelvingOrder') AS shelving_order,
    jsonb_extract_path_text(items.jsonb,'enumeration') AS enumeration,
    jsonb_extract_path_text(items.jsonb,'chronology') AS chronology,
    jsonb_extract_path_text(items.jsonb,'copyNumber') AS copy_number,
    jsonb_extract_path_text(items.jsonb,'numberOfPieces') AS num_pieces,
    jsonb_extract_path_text(items.jsonb,'descriptionOfPieces') AS desc_of_pieces,
    NULL AS purchase_order_line_item_id,
    NULL AS vendor_line_item_id,
    NULL AS fund,
    NULL AS price,
    NULL AS claims_returned,
    NULL AS claims_returned_date_created,
    NULL AS claims_returned_note,
    NULL AS current_borrower,
    NULL AS proxy_borrower,
    NULL AS check_out_date_time,
    NULL AS due_date_time,
    NULL AS check_in_note,
    NULL AS item_damaged_status,
    NULL AS item_damaged_note,
    NULL AS missing_pieces,
    NULL AS missing_pieces_effective_date,
    NULL AS missing_pieces_count,
    NULL AS missing_pieces_note,
    NULL AS barcode_arsl,
    NULL AS high_density_storage_id,
    NULL AS num_of_renew,
    jsonb_extract_path_text(items.jsonb,'metadata','createdByUsername') AS created_by,
    jsonb_extract_path_text(items.jsonb,'metadata','createdDate')::timestamp with time zone AS date_created,
    jsonb_extract_path_text(items.jsonb,'metadata','updatedByUsername') AS updated_by,
    jsonb_extract_path_text(items.jsonb,'metadata','updatedDate')::timestamp with time zone AS date_updated,
    NULL AS unique_id_prefix,
    NULL AS org_due_date_time,
    NULL AS volume_number
FROM
    folio_inventory.item AS items
    JOIN folio_inventory.holdings_record AS holdings ON holdings.id = items.holdingsrecordid
    LEFT JOIN folio_inventory.location AS locations ON items.effectivelocationid = locations.id;

/*ItemNote*/
/* ~2 min. */
TRUNCATE TABLE local_ole.ole_ds_item_note_t CASCADE;
INSERT INTO local_ole.ole_ds_item_note_t
SELECT
    (jsonb_extract_path_text(items.jsonb,'hrid')::int * 10) + notes.ORDINALITY AS item_note_id,
    CAST(jsonb_extract_path_text(items.jsonb,'hrid') AS integer ) AS item_id,
    CASE WHEN (jsonb_extract_path_text(notes.jsonb,'staffOnly'))::boolean
        THEN 'nonPublic'
        ELSE 'Public'
    END AS type,
    jsonb_extract_path_text(notes.jsonb,'note') AS note,
    NULL AS date_updated
FROM
    folio_inventory.item AS items
    CROSS JOIN jsonb_array_elements(jsonb_extract_path(jsonb,'notes')) WITH ORDINALITY AS notes(jsonb);

/*ItemHolding*/
TRUNCATE TABLE local_ole.ole_ds_item_holdings_t CASCADE;
INSERT INTO local_ole.ole_ds_item_holdings_t
SELECT
NULL AS item_holdings_id,
NULL AS holdings_id,
NULL AS item_id,
NULL AS date_updated
LIMIT 0;

/*RequestType*/
TRUNCATE TABLE local_ole.ole_dlvr_rqst_typ_t CASCADE;
/*
 * strategy: since there are so few Request Types, and because Pull List
 * hard-codes request type by ID, explicitly enumerate request types
 * and mapping to request type IDs.
 * FOLIO stores the req type_ as_ a string, must look up code
 * from this table.
 *
 * We will see if this is less complicated than generating MD5...
 */
WITH rqst_types(rqst_type, rqst_id) AS (
    VALUES
        ('Recall', '2'),
        ('Hold', '4'),
        ('Page', '6')
)
INSERT INTO local_ole.ole_dlvr_rqst_typ_t
SELECT
    rqst_id AS ole_rqst_typ_id,
    rqst_type AS ole_rqst_typ_cd,
    rqst_type AS ole_rqst_typ_nm,
    'Y' AS row_act_ind,
    rqst_id AS obj_id,
    1.0 AS ver_nbr,
    rqst_type AS ole_rqst_typ_desc
FROM rqst_types;

/*Desk*/
TRUNCATE TABLE local_ole.ole_crcl_dsk_t CASCADE;
INSERT INTO local_ole.ole_crcl_dsk_t
SELECT
    jsonb_extract_path_text(jsonb,'code') AS ole_crcl_dsk_code,
    jsonb_extract_path_text(jsonb,'discoveryDisplayName') AS ole_crcl_dsk_pub_name,
    jsonb_extract_path_text(jsonb,'name') AS ole_crcl_dsk_staff_name,
    'Y' AS actv_ind,
    CASE WHEN jsonb_extract_path_text(jsonb,'pickupLocation')::boolean THEN 'Y' ELSE 'N' END AS pk_up_locn_ind,
    CASE WHEN (jsonb_extract_path_text(jsonb,'code') = 'ITS' OR jsonb_extract_path_text(jsonb,'code') = 'POLSKY') THEN 'N' ELSE 'Y' END AS asr_pk_up_locn_ind,
    (jsonb_extract_path_text(jsonb,'holdShelfExpiryPeriod','duration'))::int AS hld_days,
    NULL AS slvng_lag_tim,
    'Y' AS prnt_slp_ind,
    id AS ole_crcl_dsk_id,
    NULL AS ole_clndr_grp_id,
    NULL AS hold_format,
    CASE WHEN jsonb_extract_path_text(jsonb,'code') = 'API' THEN 'N' ELSE 'Y' END AS hold_queue,
    NULL AS reply_to_email,
    NULL AS rqst_expirtin_days,
    NULL AS staffed,
    NULL AS renew_lost_itm,
    NULL AS show_onhold_itm,
    NULL AS dflt_rqst_typ_id,
    NULL AS dflt_pick_up_locn_id,
    NULL AS from_email,
    id AS uc_obj_id
FROM folio_inventory.service_point;

/*DeskLocation*/
TRUNCATE TABLE local_ole.ole_crcl_dsk_locn_t CASCADE;
INSERT INTO local_ole.ole_crcl_dsk_locn_t
SELECT
NULL AS ole_crcl_dsk_locn_id,
NULL AS ole_crcl_dsk_id,
NULL AS ole_crcl_dsk_locn,
NULL AS ole_crcl_pickup_dsk_locn,
NULL AS locn_popup,
NULL AS locn_popup_msg
LIMIT 0;

/*DeskUser*/
TRUNCATE TABLE local_ole.ole_circ_dsk_dtl_t CASCADE;
INSERT INTO local_ole.ole_circ_dsk_dtl_t
SELECT
NULL AS crcl_dsk_dtl_id,
NULL AS optr_id,
NULL AS default_loc,
NULL AS allowed_loc,
NULL AS obj_id,
1.0 AS ver_nbr,
NULL AS crcl_dsk_id
LIMIT 0;

/*TemporaryLoan*/
TRUNCATE TABLE local_ole.ole_dlvr_temp_circ_record CASCADE;
INSERT INTO local_ole.ole_dlvr_temp_circ_record
SELECT
NULL AS tmp_cir_his_rec_id,
NULL AS ole_ptrn_id,
NULL AS itm_id,
NULL AS circ_loc_id,
NULL AS check_in_dt_time,
NULL AS due_dt_time,
NULL AS check_out_dt_time,
NULL AS item_uuid,
NULL AS ole_proxy_ptrn_id,
NULL AS uc_item_id
LIMIT 0;

/*PastLoan*/
TRUNCATE TABLE local_ole.ole_dlvr_circ_record CASCADE;
INSERT INTO local_ole.ole_dlvr_circ_record
SELECT
    loan_hist.id AS cir_his_rec_id,
    jsonb_extract_path_text(loan_hist.jsonb,'loan','id') AS loan_tran_id,
    NULL AS cir_policy_id,
    jsonb_extract_path_text(loan_hist.jsonb,'loan','userId') AS ole_ptrn_id, /* must be equal to krim_entity_t.entity_id, = user_users.id */
    NULL AS ptrn_typ_id,
    NULL AS affiliation_id,
    NULL AS department_id,
    NULL AS other_affiliation,
    NULL AS statistical_category,
    jsonb_extract_path_text(item.jsonb,'barcode') AS itm_id,
    NULL AS bib_tit,
    NULL AS bib_auth,
    NULL AS bib_edition,
    NULL AS bib_pub,
    NULL AS bib_pub_dt,
    NULL AS bib_isbn,
    NULL AS proxy_ptrn_id,
    (jsonb_extract_path_text(loan_hist.jsonb,'loan','dueDate'))::timestamp AS due_dt_time,
    NULL AS past_due_dt_time,
    (jsonb_extract_path_text(loan_hist.jsonb,'loan','metadata','createdDate'))::timestamp AS crte_dt_time,
    NULL AS modi_dt_time,
    jsonb_extract_path_text(loan_hist.jsonb,'loan','checkoutServicePointId') AS circ_loc_id,
    NULL AS optr_crte_id,
    NULL AS optr_modi_id,
    NULL AS mach_id,
    NULL AS ovrr_optr_id,
    NULL AS num_renewals,
    NULL AS num_overdue_notices_sent,
    NULL AS overdue_notice_date,
    NULL AS ole_rqst_id,
    NULL AS repmnt_fee_ptrn_bill_id,
    NULL AS check_in_dt_time,
    NULL AS check_in_optr_id,
    NULL AS check_in_mach_id,
    item.id AS item_uuid,
    NULL AS itm_locn,
    NULL AS hldng_locn,
    NULL AS item_typ_id,
    NULL AS temp_item_typ_id,
    NULL AS check_in_dt_time_ovr_rd,
    (jsonb_extract_path_text(item.jsonb,'hrid'))::integer AS uc_item_id
FROM folio_circulation.audit_loan AS loan_hist
    LEFT JOIN folio_inventory.item AS item ON jsonb_extract_path_text(loan_hist.jsonb,'loan','itemId')::uuid = item.id;

/*Return*/
TRUNCATE TABLE local_ole.ole_return_history_t CASCADE;
INSERT INTO local_ole.ole_return_history_t
SELECT
    check_ins.id AS id,
    jsonb_extract_path_text(item.jsonb,'barcode') AS item_barcode,
    jsonb_extract_path_text(check_ins.jsonb,'itemId')::uuid AS item_uuid,
    jsonb_extract_path_text(check_ins.jsonb,'occurredDateTime') AS occurred_date_time,
    /* operator JOINs on krim_prncpl_t.PRNCPL_ID, should be same as user_users.id */
    jsonb_extract_path_text(check_ins.jsonb,'performedByUserId') AS operator,
    jsonb_extract_path_text(svc_pts.jsonb,'code') AS cir_desk_loc,
    NULL AS cir_desk_route_to,
    1.0 AS ver_nbr,
    check_ins.id AS obj_id,
    upper(jsonb_extract_path_text(item.jsonb,'status','name')) AS returned_item_status,
    jsonb_extract_path_text(item.jsonb,'hrid')::integer AS uc_item_id
FROM folio_circulation.check_in AS check_ins
    LEFT JOIN folio_inventory.item AS item ON jsonb_extract_path_text(check_ins.jsonb,'itemId')::uuid = item.id
    LEFT JOIN folio_inventory.service_point AS svc_pts ON jsonb_extract_path_text(check_ins.jsonb,'servicePointId')::uuid = svc_pts.id;

/*RecentReturn*/
TRUNCATE TABLE local_ole.ole_dlvr_recently_returned_t CASCADE;
INSERT INTO local_ole.ole_dlvr_recently_returned_t
SELECT
NULL AS id,
NULL AS circ_desk_id,
NULL AS item_uuid,
NULL AS uc_item_id
LIMIT 0;

/*FeeType*/
TRUNCATE TABLE local_ole.ole_dlvr_ptrn_fee_type_t CASCADE;
INSERT INTO local_ole.ole_dlvr_ptrn_fee_type_t
SELECT
NULL AS fee_typ_id,
NULL AS fee_typ_cd,
NULL AS fee_typ_nm,
NULL AS obj_id,
1.0 AS ver_nbr
LIMIT 0;

/*PaymentStatus*/
TRUNCATE TABLE local_ole.ole_ptrn_pay_sta_t CASCADE;
INSERT INTO local_ole.ole_ptrn_pay_sta_t
SELECT
NULL AS pay_sta_id,
NULL AS pay_sta_code,
NULL AS pay_sta_name,
NULL AS obj_id,
1.0 AS ver_nbr
LIMIT 0;

/*PatronInvoice*/
TRUNCATE TABLE local_ole.ole_dlvr_ptrn_bill_t CASCADE;
INSERT INTO local_ole.ole_dlvr_ptrn_bill_t
SELECT
NULL AS ptrn_bill_id,
NULL AS obj_id,
1.0 AS ver_nbr,
NULL AS ole_ptrn_id,
NULL AS proxy_ptrn_id,
NULL AS tot_amt_due,
NULL AS unpaid_bal,
NULL AS pay_method_id,
NULL AS pay_amt,
NULL AS pay_dt,
NULL AS pay_optr_id,
NULL AS pay_machine_id,
NULL AS crte_dt_time,
NULL AS optr_crte_id,
NULL AS optr_machine_id,
NULL AS pay_note,
NULL AS note,
NULL AS bill_reviewed,
NULL AS crdt_issued,
NULL AS crdt_remaining,
NULL AS manual_bill
LIMIT 0;

/*PatronInvoiceItem*/
TRUNCATE TABLE local_ole.ole_dlvr_ptrn_bill_fee_typ_t CASCADE;
INSERT INTO local_ole.ole_dlvr_ptrn_bill_fee_typ_t
SELECT
NULL AS id,
NULL AS ptrn_bill_id,
NULL AS itm_uuid,
NULL AS pay_status_id,
NULL AS fee_typ_id,
NULL AS fee_typ_amt,
NULL AS itm_barcode,
NULL AS balance_amt,
NULL AS ptrn_bill_date,
NULL AS pay_forgive_note,
NULL AS pay_error_note,
NULL AS pay_cancel_note,
NULL AS pay_general_note,
NULL AS due_dt_time,
NULL AS check_out_dt_time,
NULL AS check_in_dt_time,
NULL AS operator_id,
NULL AS itm_title,
NULL AS itm_author,
NULL AS itm_type,
NULL AS itm_call_num,
NULL AS itm_copy_num,
NULL AS itm_enum,
NULL AS itm_chron,
NULL AS itm_loc,
NULL AS check_in_dt_time_ovr_rd,
NULL AS crdt_issued,
NULL AS crdt_remaining,
NULL AS pay_credit_note,
NULL AS pay_transfer_note,
NULL AS pay_refund_note,
NULL AS pay_can_crdt_note,
NULL AS manual_bill,
NULL AS rnwl_dt_time,
NULL AS uc_item_id
LIMIT 0;

/*Payment*/
TRUNCATE TABLE local_ole.ole_dlvr_ptrn_bill_pay_t CASCADE;
INSERT INTO local_ole.ole_dlvr_ptrn_bill_pay_t
SELECT
NULL AS id,
NULL AS itm_line_id,
NULL AS bill_pay_amt,
NULL AS crte_dt_time,
NULL AS optr_crte_id,
NULL AS trns_number,
NULL AS trns_note,
NULL AS trns_mode,
NULL AS note
LIMIT 0;


/*Loan*/
TRUNCATE TABLE local_ole.ole_dlvr_loan_t CASCADE;
INSERT INTO local_ole.ole_dlvr_loan_t
SELECT
NULL AS loan_tran_id,
NULL AS cir_policy_id,
NULL AS ole_ptrn_id,
NULL AS itm_id,
NULL AS ole_proxy_borrower_nm,
NULL AS proxy_ptrn_id,
NULL AS curr_due_dt_time,
NULL AS past_due_dt_time,
NULL AS crte_dt_time,
NULL AS circ_loc_id,
NULL AS optr_crte_id,
NULL AS mach_id,
NULL AS ovrr_optr_id,
NULL AS num_renewals,
NULL AS num_overdue_notices_sent,
NULL AS n_overdue_notice,
NULL AS overdue_notice_date,
NULL AS ole_rqst_id,
NULL AS repmnt_fee_ptrn_bill_id,
NULL AS crtsy_ntce,
NULL AS obj_id,
1.0 AS ver_nbr,
NULL AS item_uuid,
NULL AS num_claims_rtrn_notices_sent,
NULL AS claims_search_count,
NULL AS last_claims_rtrn_search_dt,
NULL AS uc_item_id
LIMIT 0;

/*PastRequest*/
TRUNCATE TABLE local_ole.ole_dlvr_rqst_hstry_rec_t CASCADE;
INSERT INTO local_ole.ole_dlvr_rqst_hstry_rec_t
SELECT
NULL AS ole_rqst_hstry_id,
NULL AS ole_rqst_id,
NULL AS ole_item_id,
NULL AS ole_loan_id,
NULL AS ole_ln_itm_num,
NULL AS ole_rqst_typ_cd,
NULL AS ole_pck_loc_cd,
NULL AS ole_oprt_id,
NULL AS ole_mach_id,
NULL AS arch_dt_time,
NULL AS obj_id,
1.0 AS ver_nbr,
NULL AS ole_req_outcome_status,
NULL AS ole_ptrn_id,
NULL AS crte_dt_time
LIMIT 0;

/*Request*/
TRUNCATE TABLE local_ole.ole_dlvr_rqst_t CASCADE;
INSERT INTO local_ole.ole_dlvr_rqst_t
SELECT
    circ_req.id AS ole_rqst_id,
    circ_req.id AS obj_id,
    1.0 AS ver_nbr,
    NULL AS po_ln_itm_no,
    jsonb_extract_path_text(circ_req.jsonb,'item','barcode') AS itm_id,
    jsonb_extract_path_text(circ_req.jsonb,'requesterId') AS ole_ptrn_id,
    jsonb_extract_path_text(circ_req.jsonb,'requester','barcode') AS ole_ptrn_barcd,
    NULL AS proxy_ptrn_id,
    NULL AS proxy_ptrn_barcd,
    rqst_typ.ole_rqst_typ_id AS ole_rqst_typ_id,
    NULL AS cntnt_desc,
    jsonb_extract_path_text(circ_req.jsonb,'requestExpirationDate') AS rqst_expir_dt_time,
    NULL AS rcal_ntc_snt_dt,
    NULL AS onhld_ntc_snt_dt,
    jsonb_extract_path_text(circ_req.jsonb,'requestDate') AS crte_dt_time,
    NULL AS modi_dt_time,
    NULL AS cpy_frmt,
    NULL AS loan_tran_id,
    NULL AS pckup_loc_id,
    NULL AS optr_crte_id,
    NULL AS optr_modi_id,
    NULL AS circ_loc_id,
    NULL AS mach_id,
    NULL AS ptrn_q_pos,
    jsonb_extract_path_text(circ_req.jsonb,'itemId') AS item_uuid,
    NULL AS rqst_stat,
    NULL AS asr_flag,
    'Item Level' AS rqst_lvl,
    NULL AS bib_id,
    NULL AS hold_exp_date,
    NULL AS rqst_note,
    NULL AS uc_bib_id,
    NULL AS uc_item_id
FROM folio_circulation.request AS circ_req
	JOIN local_ole.ole_dlvr_rqst_typ_t AS rqst_typ ON ole_rqst_typ_cd = jsonb_extract_path_text(circ_req.jsonb,'requestType');
