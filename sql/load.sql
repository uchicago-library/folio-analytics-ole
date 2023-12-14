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
FROM local.uc_countries;

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
CASE WHEN data#>>'{personal,email}' LIKE '%uchicago.edu' OR data#>>'{personal,email}' LIKE '%uchospitals.edu' THEN 'CMP' ELSE 'HM' END AS email_typ_cd,
data#>>'{personal,email}' AS email_addr,
'Y' AS dflt_ind,
'Y' AS actv_ind,
(data#>>'{metadata,updatedDate}')::timestamp with time zone AS last_updt_dt
FROM user_users;

/*Address*/
TRUNCATE TABLE local_ole.krim_entity_addr_t CASCADE;
INSERT INTO local_ole.krim_entity_addr_t
SELECT
md5(id || coalesce(a->>'addressTypeId','') || coalesce(a->>'addressLine1','')) AS entity_addr_id,
md5(id || coalesce(a->>'addressTypeId','') || coalesce(a->>'addressLine1','')) AS obj_id,
1.0 AS ver_nbr,
'PERSON' AS ent_typ_cd,
id AS entity_id,
a->>'addressTypeId' AS addr_typ_cd,
a->>'addressLine1' AS addr_line_1,
a->>'addressLine2' AS addr_line_2,
NULL AS addr_line_3,
a->>'city' AS city,
(a->>'region')::varchar(2) AS state_pvc_cd,
a->>'postalCode' AS postal_cd,
a->>'countryId' AS postal_cntry_cd,
/* FOLIO had a primary address, not a default. Few notices delivered by mail now */
NULL AS dflt_ind,
'Y' AS actv_ind,
(data#>>'{metadata,updatedDate}')::timestamp with time zone AS last_updt_dt,
NULL AS attn_line,
NULL AS addr_fmt,
NULL AS mod_dt,
NULL AS valid_dt,
'Y' AS valid_ind,
NULL AS note_msg
FROM user_users u, json_array_elements(data#>'{personal,addresses}') a ;

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
data->>'barcode' AS barcode,
CASE WHEN data->>'patronGroup' IS NOT NULL THEN data->>'patronGroup' ELSE '06f2d60e-0b07-49ca-b8c7-e1d49808e0b7' END AS borr_typ,
CASE WHEN (data->>'active')::boolean THEN 'Y' ELSE 'N' END AS actv_ind,
NULL AS general_block,
NULL AS paging_privilege,
NULL AS courtesy_notice,
NULL AS delivery_privilege,
(data->>'expirationDate')::timestamp with time zone AS expiration_date,
(data->>'enrollmentDate')::timestamp with time zone AS activation_date,
NULL AS general_block_nt,
NULL AS inv_barcode_num,
NULL AS inv_barcode_num_eff_date,
CASE data#>>'{customFields,source}' 
WHEN 'University' THEN '9e58b46a-1ba9-430f-8373-0a343231aaf0' 
WHEN 'Library' THEN '6306ab00-04d3-41ce-8691-25ccda4daff5' 
ELSE NULL END AS ole_src,
md5(data#>>'{customFields,category}') AS ole_stat_cat,
NULL AS photograph
FROM user_users;

/*PatronId1*/
TRUNCATE TABLE local_ole.ole_ptrn_local_id_t CASCADE;
INSERT INTO local_ole.ole_ptrn_local_id_t
SELECT
id AS ole_ptrn_local_seq_id,
id AS obj_id,
1.0 AS ver_nbr,
id AS ole_ptrn_id,
data->>'externalSystemId' AS local_id
FROM user_users 
WHERE data->>'externalSystemId' IS NOT NULL;

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
(u.data#>>'{customFields,studentId}')::int AS student_id,
CASE WHEN CHAR_LENGTH(u.data->>'externalSystemId') = 9 THEN u.data->>'externalSystemId' ELSE NULL END AS chicago_id, 
u.data#>>'{customFields,staffDivision}' AS staff_division,
u.data#>>'{customFields,staffDepartment}' AS staff_department,
u.data#>>'{customFields,studentDivision}' AS student_division,
u.data#>>'{customFields,studentDepartment}' AS student_department,
u.data#>>'{customFields,status}' AS status,
u.data#>>'{customFields,statuses}' AS statuses,
u.data#>>'{customFields,staffStatus}' AS staff_status,
u.data#>>'{customFields,studentStatus}' AS student_status,
(u.data#>>'{customFields,studentRestriction}')::boolean AS student_restriction,
u.data#>>'{customFields,staffPrivileges}' AS staff_privileges,
COALESCE((u.data#>>'{customFields,deceased}')::boolean, false) AS deceased, 
COALESCE((u.data#>>'{customFields,collections}')::boolean, false) AS collections, 
(u.data#>>'{metadata,createdDate}')::timestamp with time zone AS creation_time,
u2.data->>'username' AS creation_user_name,
(u.data#>>'{metadata,updatedDate}')::timestamp with time zone AS last_write_time,
u3.data->>'username' AS last_write_user_name
FROM user_users u
LEFT JOIN user_groups g ON g.id = u.data->>'patronGroup'
LEFT JOIN user_users u2 ON u2.id = u.data#>>'{metadata,createdByUserId}'
LEFT JOIN user_users u3 ON u3.id = u.data#>>'{metadata,updatedByUserId}';

/*Proxy patrons*/
TRUNCATE TABLE local_ole.ole_proxy_ptrn_t CASCADE;
INSERT INTO local_ole.ole_proxy_ptrn_t
SELECT 
    id AS ole_proxy_ptrn_id,
    id AS obj_id,
    1 AS ver_nbr,
    user_id AS ole_ptrn_id,
    proxy_user_id AS ole_proxy_ptrn_ref_id,
    expiration_date::timestamp AS ole_proxy_ptrn_exp_dt,
    (data#>>'{metadata,createdDate}')::timestamp AS ole_proxy_ptrn_act_dt,
    CASE WHEN (status = 'Active') THEN 'Y' ELSE 'N' END AS actv_ind
FROM user_proxiesfor;

/*User*/
TRUNCATE TABLE local_ole.krim_prncpl_t CASCADE;
INSERT INTO local_ole.krim_prncpl_t
SELECT
id AS prncpl_id,
id AS obj_id,
1.0 AS ver_nbr,
data->>'username' AS prncpl_nm,
id AS entity_id,
NULL AS prncpl_pswd,
CASE WHEN (data->>'active')::boolean THEN 'Y' ELSE 'N' END AS actv_ind,
(data#>>'{metadata,updatedDate}')::timestamp with time zone AS last_updt_dt
FROM user_users
WHERE data->>'username' IS NOT NULL;

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
    substring(name FOR 40) AS shvlg_schm_cd,
    name AS shvlg_schm_nm,
    source AS src,
    '2012-03-22 00:00:00.0'::timestamp AS src_dt,
    'Y' AS row_act_ind,
    NULL AS date_updated
FROM inventory_call_number_types;

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
  loan_types.name AS itm_typ_cd,
  loan_types.name AS itm_typ_nm,
  NULL AS itm_typ_desc,
  '' AS src,
  NULL AS src_dt,
  '' AS row_act_ind,
  loan_types.id AS obj_id,
  1.0 AS ver_nbr,
  (loan_types.data#>>'{metadata,updatedDate}')::timestamp with time zone AS date_updated
FROM public.inventory_loan_types loan_types;

/*Location*/
TRUNCATE TABLE local_ole.ole_locn_t CASCADE;
INSERT INTO local_ole.ole_locn_t
SELECT
    local_ole.uuid_to_ole_id_str(id) AS locn_id,
    id AS obj_id,
    1.0 AS ver_nbr,
    replace(code, 'UC/HP/', 'UC/') AS locn_cd,
    name AS locn_name,
    '5' AS level_id,
    NULL AS parent_locn_id,
    CASE WHEN is_active THEN 'Y' ELSE 'N' END AS row_act_ind
FROM inventory_locations;

/*Bib*/
/* ~17 minutes */
TRUNCATE TABLE local_ole.ole_ds_bib_t CASCADE;
INSERT INTO local_ole.ole_ds_bib_t
SELECT 
CAST( ii.hrid AS integer ) AS bib_id,
NULL AS former_id,
NULL AS fast_add,
(CASE WHEN ii.discovery_suppress THEN 'Y' ELSE 'N' END) AS staff_only,
ii.data#>>'{metadata,createdByUsername}' AS created_by,
(ii.data#>>'{metadata,createdDate}')::timestamp with time zone AS date_created,
ii.data#>>'{metadata,updatedByUsername}' AS updated_by,
(ii.data#>>'{metadata,updatedDate}')::timestamp with time zone AS date_updated,
iis."name" AS status,
NULL AS status_updated_by,
ii.status_updated_date AS status_updated_date,
NULL AS unique_id_prefix,
NULL AS CONTENT
FROM public.inventory_instances ii 
LEFT JOIN public.inventory_instance_statuses iis 
       ON iis.id = ii.status_id;

/*BibInfo*/
/* ~15 minutes */
TRUNCATE TABLE local_ole.ole_ds_bib_info_t CASCADE;
INSERT INTO local_ole.ole_ds_bib_info_t
SELECT
    'wbm-'||hrid AS bib_id_str, /* using OLE nomenclature, could use UUIDs */
    hrid::int AS bib_id,
    title AS title,
    data#>>'{contributors, 0, name}' AS author,
    data#>>'{publication, 0, publisher}' AS publisher,
    NULL AS isxn,
    (data#>>'{metadata, updatedDate}')::timestamp AS date_updated
FROM inventory_instances;

/*Holding*/
/* ~10 minutes */
TRUNCATE TABLE local_ole.ole_ds_holdings_t CASCADE;
INSERT INTO local_ole.ole_ds_holdings_t
SELECT
	holdings.hrid::int AS holdings_id,
	instance.hrid::int AS bib_id,
	holdings_type.name AS holdings_type,
	NULL AS former_holdings_id,
	(CASE WHEN holdings.discovery_suppress THEN 'Y' ELSE 'N' END) AS staff_only,
	NULL AS location_id,
	holdings_permanent_location.code AS location,
	NULL AS location_level,
    call_number_type_id::uuid AS call_number_type_id,
	holdings.call_number_prefix AS call_number_prefix,
	holdings.call_number AS call_number,
	NULL AS shelving_order,
	CASE WHEN char_length(holdings.copy_number) > 20 
		THEN substring(holdings.copy_number FOR 20)
		ELSE holdings.copy_number 
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
	holdings.data#>>'{metadata,createdByUsername}' AS created_by,
	(holdings.data#>>'{metadata,createdDate}')::timestamp with time zone AS date_created,
	holdings.data#>>'{metadata,updatedByUsername}' AS updated_by,
	(holdings.data#>>'{metadata,updatedDate}')::timestamp with time zone AS date_updated
FROM 
	inventory_holdings holdings
	JOIN inventory_instances instance ON instance.id = holdings.instance_id
	LEFT JOIN inventory_holdings_types AS holdings_type ON holdings.holdings_type_id = holdings_type.id
	LEFT JOIN inventory_locations AS holdings_permanent_location ON holdings.permanent_location_id = holdings_permanent_location.id;

/*HoldingNote*/
/* ~1.5 min. */
TRUNCATE TABLE local_ole.ole_ds_holdings_note_t CASCADE;
INSERT INTO local_ole.ole_ds_holdings_note_t
SELECT
    /* need multiply by 100, multiply by 10 results in non-unique key */
    (holdings.hrid::int * 100) + notes.ORDINALITY AS holdings_note_id,
    CAST( holdings.hrid AS integer ) AS holdings_id,
    CASE WHEN (notes.data#>>'{staffOnly}')::boolean
        THEN 'nonPublic' 
        ELSE 'Public'
    END AS type,
    json_extract_path_text(notes.data, 'note') AS note,
    NULL AS date_updated
FROM
    inventory_holdings AS holdings
    CROSS JOIN json_array_elements(json_extract_path(data, 'notes')) WITH ORDINALITY AS notes (data);

/*Item*/
/* ~15 minutes */
TRUNCATE TABLE local_ole.ole_ds_item_t CASCADE;
INSERT INTO local_ole.ole_ds_item_t
SELECT
    items.hrid::int AS item_id,
    holdings.hrid::int AS holdings_id,
    items.barcode AS barcode,
    NULL AS fast_add,
    (CASE WHEN items.discovery_suppress THEN 'Y' ELSE 'N' END) AS staff_only,
    NULL AS uri,
    items.permanent_loan_type_id AS item_type_id,
    items.temporary_loan_type_id AS temp_item_type_id,
    md5(items.data#>>'{status,name}') AS item_status_id,
    (items.data#>>'{status,date}')::timestamp AS item_status_date_updated,
    local_ole.uuid_to_ole_id_int(items.permanent_location_id) AS location_id,
    locations.code AS location,
    NULL AS location_level,
    call_number_type_id::uuid AS call_number_type_id,
    item_level_call_number_prefix AS call_number_prefix,
    item_level_call_number AS call_number,
    items.effective_shelving_order AS shelving_order,
    enumeration AS enumeration,
    chronology AS chronology,
    items.copy_number AS copy_number,
    number_of_pieces AS num_pieces,
    description_of_pieces AS desc_of_pieces,
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
    items.data#>>'{metadata,createdByUsername}' AS created_by,
    (items.data#>>'{metadata,createdDate}')::timestamp with time zone AS date_created,
    items.data#>>'{metadata,updatedByUsername}' AS updated_by,
    (items.data#>>'{metadata,updatedDate}')::timestamp with time zone AS date_updated,
    NULL AS unique_id_prefix,
    NULL AS org_due_date_time,
    NULL AS volume_number
FROM
    inventory_items items
    JOIN inventory_holdings holdings ON holdings.id = items.holdings_record_id
    LEFT JOIN inventory_locations AS locations ON items.effective_location_id = locations.id;

/*ItemNote*/
/* ~2 min. */
TRUNCATE TABLE local_ole.ole_ds_item_note_t CASCADE;
INSERT INTO local_ole.ole_ds_item_note_t
SELECT
    (items.hrid::int * 10) + notes.ORDINALITY AS item_note_id,
    CAST( items.hrid AS integer ) AS item_id,
    CASE WHEN (notes.data#>>'{staffOnly}')::boolean
        THEN 'nonPublic' 
        ELSE 'Public'
    END AS type,
    json_extract_path_text(notes.data, 'note') AS note,
    NULL AS date_updated
FROM
    inventory_items AS items
    CROSS JOIN json_array_elements(json_extract_path(data, 'notes')) WITH ORDINALITY AS notes (data);

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
    code AS ole_crcl_dsk_code,
    discovery_display_name AS ole_crcl_dsk_pub_name,
    "name" AS ole_crcl_dsk_staff_name,
    'Y' AS actv_ind,
    CASE WHEN pickup_location THEN 'Y' ELSE 'N' END AS pk_up_locn_ind,
    CASE WHEN code = 'ITS' OR code = 'POLSKY' THEN 'N' ELSE 'Y' END AS asr_pk_up_locn_ind,
    ("data"#>>'{holdShelfExpiryPeriod, duration}')::int AS hld_days,
    NULL AS slvng_lag_tim,
    'Y' AS prnt_slp_ind,
    id AS ole_crcl_dsk_id,
    NULL AS ole_clndr_grp_id,
    NULL AS hold_format,
    CASE WHEN code = 'API' THEN 'N' ELSE 'Y' END AS hold_queue,
    NULL AS reply_to_email,
    NULL AS rqst_expirtin_days,
    NULL AS staffed,
    NULL AS renew_lost_itm,
    NULL AS show_onhold_itm,
    NULL AS dflt_rqst_typ_id,
    NULL AS dflt_pick_up_locn_id,
    NULL AS from_email,
    id AS uc_obj_id
FROM public.inventory_service_points;

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
    loan_hist.data#>>'{loan, id}' AS loan_tran_id,
    NULL AS cir_policy_id,
    loan_hist.data#>>'{loan, userId}' AS ole_ptrn_id, /* must be equal to krim_entity_t.entity_id, = user_users.id */
    NULL AS ptrn_typ_id,
    NULL AS affiliation_id,
    NULL AS department_id,
    NULL AS other_affiliation,
    NULL AS statistical_category,
    item.barcode AS itm_id,
    NULL AS bib_tit,
    NULL AS bib_auth,
    NULL AS bib_edition,
    NULL AS bib_pub,
    NULL AS bib_pub_dt,
    NULL AS bib_isbn,
    NULL AS proxy_ptrn_id,
    (loan_hist.data#>>'{loan, dueDate}')::timestamp AS due_dt_time,
    NULL AS past_due_dt_time,
    (loan_hist.data#>>'{loan, metadata, createdDate}')::timestamp AS crte_dt_time,
    NULL AS modi_dt_time,
    loan_hist.data#>>'{loan, checkoutServicePointId}' AS circ_loc_id,
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
    (item.hrid)::integer AS uc_item_id
FROM circulation_loan_history loan_hist
    LEFT JOIN inventory_items AS item ON loan_hist.data#>>'{loan, itemId}' = item.id;

/*Return*/
TRUNCATE TABLE local_ole.ole_return_history_t CASCADE;
INSERT INTO local_ole.ole_return_history_t
SELECT
    check_ins.id AS id,
    item.barcode AS item_barcode,
    check_ins.item_id AS item_uuid,
    check_ins.occurred_date_time,
    /* operator JOINs on krim_prncpl_t.PRNCPL_ID, should be same as user_users.id */
    check_ins.performed_by_user_id AS operator,
    svc_pts.code AS cir_desk_loc,
    NULL AS cir_desk_route_to,
    1.0 AS ver_nbr,
    check_ins.id AS obj_id,
    upper(item.data#>>'{status, name}') AS returned_item_status,
    item.hrid::integer AS uc_item_id
FROM circulation_check_ins check_ins
    LEFT JOIN inventory_items AS item ON check_ins.item_id = item.id
    LEFT JOIN inventory_service_points AS svc_pts ON check_ins.service_point_id = svc_pts.id;

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
    circ_req.data#>>'{item, barcode}' AS itm_id,
    circ_req.requester_id AS ole_ptrn_id,
    circ_req.data#>>'{requester, barcode}' AS ole_ptrn_barcd,
    NULL AS proxy_ptrn_id,
    NULL AS proxy_ptrn_barcd,
    rqst_typ.ole_rqst_typ_id AS ole_rqst_typ_id,
    NULL AS cntnt_desc,
    circ_req.request_expiration_date AS rqst_expir_dt_time,
    NULL AS rcal_ntc_snt_dt,
    NULL AS onhld_ntc_snt_dt,
    circ_req.request_date AS crte_dt_time,
    NULL AS modi_dt_time,
    NULL AS cpy_frmt,
    NULL AS loan_tran_id,
    NULL AS pckup_loc_id,
    NULL AS optr_crte_id,
    NULL AS optr_modi_id,
    NULL AS circ_loc_id,
    NULL AS mach_id,
    NULL AS ptrn_q_pos,
    circ_req.item_id AS item_uuid,
    NULL AS rqst_stat,
    NULL AS asr_flag,
    'Item Level' AS rqst_lvl,
    NULL AS bib_id,
    NULL AS hold_exp_date,
    NULL AS rqst_note,
    NULL AS uc_bib_id,
    NULL AS uc_item_id
FROM circulation_requests circ_req
    JOIN local_ole.ole_dlvr_rqst_typ_t rqst_typ
        ON ole_rqst_typ_cd = circ_req.request_type;
