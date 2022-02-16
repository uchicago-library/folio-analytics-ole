CREATE EXTENSION IF NOT EXISTS citext;

/*Country*/
CREATE TABLE local_ole.krlc_cntry_t (
    postal_cntry_cd VARCHAR(2) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    postal_cntry_nm VARCHAR(255),
    pstl_cntry_rstrc_ind VARCHAR(1) NOT NULL,
    actv_ind VARCHAR(1) NOT NULL,
    alt_postal_cntry_cd VARCHAR(3),
    CONSTRAINT PK_krlc_cntry_t PRIMARY KEY(postal_cntry_cd)
);

/*State*/
CREATE TABLE local_ole.krlc_st_t (
    postal_state_cd VARCHAR(2) NOT NULL,
    postal_cntry_cd VARCHAR(2) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    postal_state_nm VARCHAR(40),
    actv_ind VARCHAR(1) NOT NULL,
    CONSTRAINT PK_krlc_st_t PRIMARY KEY(postal_state_cd, postal_cntry_cd)
);

/*PostalCode*/
CREATE TABLE local_ole.krlc_pstl_cd_t (
    postal_cd VARCHAR(20) NOT NULL,
    county_cd VARCHAR(10),
    obj_id VARCHAR(36) NOT NULL,
    postal_state_cd VARCHAR(2),
    postal_cntry_cd VARCHAR(2) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    postal_city_nm VARCHAR(30),
    actv_ind VARCHAR(1) NOT NULL,
    CONSTRAINT PK_krlc_pstl_cd_t PRIMARY KEY(postal_cd, postal_cntry_cd)
);

/*Rule*/
CREATE TABLE local_ole.krms_rule_t (
    rule_id VARCHAR(40) NOT NULL,
    nmspc_cd VARCHAR(20) NOT NULL,
    nm VARCHAR(100) NOT NULL,
    typ_id VARCHAR(40),
    prop_id VARCHAR(40),
    actv VARCHAR(1) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    desc_txt TEXT,
    CONSTRAINT PK_krms_rule_t PRIMARY KEY(rule_id)
);

/*Role*/
CREATE TABLE local_ole.krim_role_t (
    role_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    role_nm VARCHAR(80) NOT NULL,
    nmspc_cd VARCHAR(20) NOT NULL,
    desc_txt TEXT,
    kim_typ_id VARCHAR(40) NOT NULL,
    actv_ind VARCHAR(1),
    last_updt_dt TIMESTAMP,
    CONSTRAINT PK_krim_role_t PRIMARY KEY(role_id)
);

/*RolePermission*/
CREATE TABLE local_ole.krim_role_perm_t (
    role_perm_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    role_id VARCHAR(40) NOT NULL,
    perm_id VARCHAR(40) NOT NULL,
    actv_ind VARCHAR(1),
    CONSTRAINT PK_krim_role_perm_t PRIMARY KEY(role_perm_id)
);

/*Source*/
CREATE TABLE local_ole.ole_dlvr_src_t (
    ole_dlvr_src_id VARCHAR(40) NOT NULL,
    ole_dlvr_src_cd VARCHAR(40) NOT NULL,
    ole_dlvr_src_desc VARCHAR(700) NOT NULL,
    ole_dlvr_src_nm VARCHAR(100) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    row_act_ind VARCHAR(1) NOT NULL,
    CONSTRAINT PK_ole_dlvr_src_t PRIMARY KEY(ole_dlvr_src_id)
);

/*PatronType*/
CREATE TABLE local_ole.ole_dlvr_borr_typ_t (
    dlvr_borr_typ_id VARCHAR(40) NOT NULL,
    dlvr_borr_typ_cd VARCHAR(40) NOT NULL,
    dlvr_borr_typ_desc VARCHAR(700) NOT NULL,
    dlvr_borr_typ_nm VARCHAR(100) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    row_act_ind VARCHAR(1) NOT NULL,
    CONSTRAINT PK_ole_dlvr_borr_typ_t PRIMARY KEY(dlvr_borr_typ_id)
);

/*PatronCategory*/
CREATE TABLE local_ole.ole_dlvr_stat_cat_t (
    ole_dlvr_stat_cat_id VARCHAR(40) NOT NULL,
    ole_dlvr_stat_cat_cd VARCHAR(40) NOT NULL,
    ole_dlvr_stat_cat_desc VARCHAR(700) NOT NULL,
    ole_dlvr_stat_cat_nm VARCHAR(100) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    row_act_ind VARCHAR(1) NOT NULL,
    CONSTRAINT PK_ole_dlvr_stat_cat_t PRIMARY KEY(ole_dlvr_stat_cat_id)
);

/*PatronNoteType*/
CREATE TABLE local_ole.ole_ptrn_nte_typ_t (
    ole_ptrn_nte_typ_id VARCHAR(40) NOT NULL,
    ole_ptrn_nte_typ_nm VARCHAR(100),
    ole_ptrn_nte_type_cd VARCHAR(8),
    obj_id VARCHAR(36),
    actv_ind VARCHAR(1),
    CONSTRAINT PK_ole_ptrn_nte_typ_t PRIMARY KEY(ole_ptrn_nte_typ_id)
);

/*Person*/
CREATE TABLE local_ole.krim_entity_t (
    entity_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    actv_ind VARCHAR(1),
    last_updt_dt TIMESTAMP,
    CONSTRAINT PK_krim_entity_t PRIMARY KEY(entity_id)
);

/*Name*/
CREATE TABLE local_ole.krim_entity_nm_t (
    entity_nm_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    entity_id VARCHAR(40),
    nm_typ_cd VARCHAR(40),
    first_nm CITEXT,
    middle_nm CITEXT,
    last_nm CITEXT,
    suffix_nm CITEXT,
    prefix_nm CITEXT,
    dflt_ind VARCHAR(1),
    actv_ind VARCHAR(1),
    last_updt_dt TIMESTAMP,
    title_nm VARCHAR(20),
    note_msg TEXT,
    nm_chng_dt TIMESTAMP,
    CONSTRAINT PK_krim_entity_nm_t PRIMARY KEY(entity_nm_id)
);

/*PhoneNumber*/
CREATE TABLE local_ole.krim_entity_phone_t (
    entity_phone_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    ent_typ_cd VARCHAR(40),
    entity_id VARCHAR(40),
    phone_typ_cd VARCHAR(40),
    phone_nbr VARCHAR(20),
    phone_extn_nbr VARCHAR(8),
    postal_cntry_cd VARCHAR(2),
    dflt_ind VARCHAR(1),
    actv_ind VARCHAR(1),
    last_updt_dt TIMESTAMP,
    CONSTRAINT PK_krim_entity_phone_t PRIMARY KEY(entity_phone_id)
);

/*EmailAddress*/
CREATE TABLE local_ole.krim_entity_email_t (
    entity_email_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    ent_typ_cd VARCHAR(40),
    entity_id VARCHAR(40),
    email_typ_cd VARCHAR(40),
    email_addr VARCHAR(200),
    dflt_ind VARCHAR(1),
    actv_ind VARCHAR(1),
    last_updt_dt TIMESTAMP,
    CONSTRAINT PK_krim_entity_email_t PRIMARY KEY(entity_email_id)
);

/*Address*/
CREATE TABLE local_ole.krim_entity_addr_t (
    entity_addr_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    ent_typ_cd VARCHAR(40),
    entity_id VARCHAR(40),
    addr_typ_cd VARCHAR(40),
    addr_line_1 VARCHAR(45),
    addr_line_2 VARCHAR(45),
    addr_line_3 VARCHAR(45),
    city VARCHAR(30),
    state_pvc_cd VARCHAR(2),
    postal_cd VARCHAR(20),
    postal_cntry_cd VARCHAR(2),
    dflt_ind VARCHAR(1),
    actv_ind VARCHAR(1),
    last_updt_dt TIMESTAMP,
    attn_line VARCHAR(45),
    addr_fmt VARCHAR(256),
    mod_dt TIMESTAMP,
    valid_dt TIMESTAMP,
    valid_ind VARCHAR(1),
    note_msg TEXT,
    CONSTRAINT PK_krim_entity_addr_t PRIMARY KEY(entity_addr_id)
);

/*Affiliation*/
CREATE TABLE local_ole.krim_entity_afltn_t (
    entity_afltn_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    entity_id VARCHAR(40),
    afltn_typ_cd VARCHAR(40),
    campus_cd VARCHAR(2),
    dflt_ind VARCHAR(1),
    actv_ind VARCHAR(1),
    last_updt_dt TIMESTAMP,
    CONSTRAINT PK_krim_entity_afltn_t PRIMARY KEY(entity_afltn_id)
);

/*Employment*/
CREATE TABLE local_ole.krim_entity_emp_info_t (
    entity_emp_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    entity_id VARCHAR(40),
    entity_afltn_id VARCHAR(40),
    emp_stat_cd VARCHAR(40),
    emp_typ_cd VARCHAR(40),
    base_slry_amt DECIMAL(15,2),
    prmry_ind VARCHAR(1),
    actv_ind VARCHAR(1),
    last_updt_dt TIMESTAMP,
    prmry_dept_cd VARCHAR(40),
    emp_id VARCHAR(40),
    emp_rec_id VARCHAR(40),
    CONSTRAINT PK_krim_entity_emp_info_t PRIMARY KEY(entity_emp_id)
);

/*Patron*/
CREATE TABLE local_ole.ole_ptrn_t (
    ole_ptrn_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36),
    ver_nbr DECIMAL(8,0),
    barcode VARCHAR(100),
    borr_typ VARCHAR(40) NOT NULL,
    actv_ind VARCHAR(1),
    general_block VARCHAR(1),
    paging_privilege VARCHAR(1),
    courtesy_notice VARCHAR(1),
    delivery_privilege VARCHAR(1),
    expiration_date TIMESTAMP,
    activation_date TIMESTAMP,
    general_block_nt VARCHAR(250),
    inv_barcode_num VARCHAR(20),
    inv_barcode_num_eff_date TIMESTAMP,
    ole_src VARCHAR(40),
    ole_stat_cat VARCHAR(40),
    photograph BYTEA,
    CONSTRAINT PK_ole_ptrn_t PRIMARY KEY(ole_ptrn_id)
);

/*PatronId1*/
CREATE TABLE local_ole.ole_ptrn_local_id_t (
    ole_ptrn_local_seq_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    ole_ptrn_id VARCHAR(40),
    local_id VARCHAR(40),
    CONSTRAINT PK_ole_ptrn_local_id_t PRIMARY KEY(ole_ptrn_local_seq_id)
);

/*PatronAddress*/
CREATE TABLE local_ole.ole_dlvr_add_t (
    dlvr_add_id VARCHAR(36) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    ole_ptrn_id VARCHAR(40),
    entity_addr_id VARCHAR(40),
    dlvr_ptrn_add_ver VARCHAR(1),
    add_valid_from TIMESTAMP,
    add_valid_to TIMESTAMP,
    ole_addr_src VARCHAR(40),
    ptrn_dlvr_add VARCHAR(1),
    CONSTRAINT PK_ole_dlvr_add_t PRIMARY KEY(dlvr_add_id)
);

/*PatronNote*/
CREATE TABLE local_ole.ole_ptrn_nte_t (
    ole_ptrn_nte_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36),
    ver_nbr DECIMAL(8,0),
    ole_ptrn_id VARCHAR(40),
    ole_ptrn_nte_typ_id VARCHAR(40),
    ole_ptrn_nte_txt TEXT,
    actv_ind VARCHAR(1) NOT NULL,
    optr_id VARCHAR(40),
    nte_crt_or_updt_date TIMESTAMP,
    CONSTRAINT PK_ole_ptrn_nte_t PRIMARY KEY(ole_ptrn_nte_id)
);

/*PersonExt*/
CREATE TABLE local_ole.uc_entity_ext (
    id VARCHAR(40) NOT NULL,
    student_id INT,
    chicago_id VARCHAR(9),
    staff_division VARCHAR(128),
    staff_department VARCHAR(128),
    student_division VARCHAR(128),
    student_department VARCHAR(128),
    status VARCHAR(128),
    statuses VARCHAR(128),
    staff_status VARCHAR(128),
    student_status VARCHAR(128),
    student_restriction BOOLEAN,
    staff_privileges VARCHAR(128),
    deceased BOOLEAN NOT NULL,
    collections BOOLEAN NOT NULL,
    creation_time TIMESTAMP,
    creation_user_name VARCHAR(128),
    last_write_time TIMESTAMP,
    last_write_user_name VARCHAR(128),
    CONSTRAINT PK_uc_entity_ext PRIMARY KEY(id)
);

/*Proxy Patron*/
CREATE TABLE local_ole.ole_proxy_ptrn_t (
    ole_proxy_ptrn_id VARCHAR(40) NOT NULL,
    obj_id varchar(40), 
    ver_nbr DECIMAL(8,0), 
    ole_ptrn_id VARCHAR(40),
    ole_proxy_ptrn_ref_id VARCHAR(40) NOT NULL,  
    ole_proxy_ptrn_exp_dt TIMESTAMP, 
    ole_proxy_ptrn_act_dt TIMESTAMP,
    actv_ind VARCHAR(1), 
    CONSTRAINT PK_ole_proxy_ptrn_t PRIMARY KEY(ole_proxy_ptrn_id)
);

/*User*/
CREATE TABLE local_ole.krim_prncpl_t (
    prncpl_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    prncpl_nm VARCHAR(100) NOT NULL,
    entity_id VARCHAR(40),
    prncpl_pswd VARCHAR(400),
    actv_ind VARCHAR(1),
    last_updt_dt TIMESTAMP,
    CONSTRAINT PK_krim_prncpl_t PRIMARY KEY(prncpl_id)
);

/*UserRole*/
CREATE TABLE local_ole.krim_role_mbr_t (
    role_mbr_id VARCHAR(40) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    role_id VARCHAR(40) NOT NULL,
    mbr_id VARCHAR(40) NOT NULL,
    mbr_typ_cd VARCHAR(1) NOT NULL,
    actv_frm_dt TIMESTAMP,
    actv_to_dt TIMESTAMP,
    last_updt_dt TIMESTAMP,
    CONSTRAINT PK_krim_role_mbr_t PRIMARY KEY(role_mbr_id)
);

/*CallNumberType*/
/*
 * Changed shvlg_schm_id to UUID from DECIMAL(8,0), so we can use native FOLIO IDs.
 */
CREATE TABLE local_ole.ole_cat_shvlg_schm_t (
    shvlg_schm_id UUID NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    shvlg_schm_cd VARCHAR(40),
    shvlg_schm_nm VARCHAR(100) NOT NULL,
    src VARCHAR(100) NOT NULL,
    src_dt TIMESTAMP NOT NULL,
    row_act_ind VARCHAR(1) NOT NULL,
    date_updated TIMESTAMP,
    CONSTRAINT PK_ole_cat_shvlg_schm_t PRIMARY KEY(shvlg_schm_id)
);

/*ItemStatus*/
CREATE TABLE local_ole.ole_dlvr_item_avail_stat_t (
    item_avail_stat_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    item_avail_stat_cd VARCHAR(40) NOT NULL,
    item_avail_stat_nm VARCHAR(200) NOT NULL,
    row_act_ind VARCHAR(1) NOT NULL,
    date_updated TIMESTAMP,
    CONSTRAINT PK_ole_dlvr_item_avail_stat_t PRIMARY KEY(item_avail_stat_id)
);

/*ItemType1*/
CREATE TABLE local_ole.ole_cat_itm_typ_t (
    itm_typ_cd_id VARCHAR(40) NOT NULL,
    itm_typ_cd VARCHAR(40) NOT NULL,
    itm_typ_nm VARCHAR(100) NOT NULL,
    itm_typ_desc VARCHAR(700),
    src VARCHAR(100) NOT NULL,
    src_dt TIMESTAMP,
    row_act_ind VARCHAR(1) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    date_updated TIMESTAMP,
    CONSTRAINT PK_ole_cat_itm_typ_t PRIMARY KEY(itm_typ_cd_id)
);

/*Location*/
CREATE TABLE local_ole.ole_locn_t (
    locn_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    locn_cd VARCHAR(40) NOT NULL,
    locn_name VARCHAR(100) NOT NULL,
    level_id VARCHAR(40) NOT NULL,
    parent_locn_id VARCHAR(40),
    row_act_ind VARCHAR(1),
    CONSTRAINT PK_ole_locn_t PRIMARY KEY(locn_id)
);

/*Bib*/
CREATE TABLE local_ole.ole_ds_bib_t (
    bib_id INT NOT NULL,
    former_id VARCHAR(45),
    fast_add VARCHAR(1),
    staff_only VARCHAR(1),
    created_by VARCHAR(40),
    date_created TIMESTAMP,
    updated_by VARCHAR(40),
    date_updated TIMESTAMP,
    status VARCHAR(100),
    status_updated_by VARCHAR(40),
    status_updated_date TIMESTAMP,
    unique_id_prefix VARCHAR(10),
    content XML,
    CONSTRAINT PK_ole_ds_bib_t PRIMARY KEY(bib_id)
);

/*BibInfo*/
CREATE TABLE local_ole.ole_ds_bib_info_t (
    bib_id_str VARCHAR(20) NOT NULL,
    bib_id INT,
    title TEXT,
    author TEXT,
    publisher TEXT,
    isxn VARCHAR(100),
    date_updated TIMESTAMP,
    CONSTRAINT PK_ole_ds_bib_info_t PRIMARY KEY(bib_id_str)
);

/*Holding*/
CREATE TABLE local_ole.ole_ds_holdings_t (
    holdings_id INT NOT NULL,
    bib_id INT NOT NULL,
    holdings_type VARCHAR(10),
    former_holdings_id VARCHAR(45),
    staff_only VARCHAR(1),
    location_id INT,
    location VARCHAR(300),
    location_level VARCHAR(300),
    call_number_type_id UUID,
    call_number_prefix VARCHAR(100),
    call_number VARCHAR(300),
    shelving_order VARCHAR(300),
    copy_number VARCHAR(20),
    receipt_status_id INT,
    publisher VARCHAR(200),
    access_status VARCHAR(40),
    access_status_date_updated TIMESTAMP,
    subscription_status VARCHAR(40),
    platform VARCHAR(200),
    imprint VARCHAR(200),
    local_persistent_uri VARCHAR(400),
    allow_ill VARCHAR(1),
    authentication_type_id INT,
    proxied_resource VARCHAR(10),
    number_simult_users INT,
    e_resource_id VARCHAR(40),
    admin_url VARCHAR(400),
    admin_username VARCHAR(100),
    admin_password VARCHAR(100),
    access_username VARCHAR(100),
    access_password VARCHAR(100),
    unique_id_prefix VARCHAR(10),
    source_holdings_content TEXT,
    initial_sbrcptn_start_dt TIMESTAMP,
    current_sbrcptn_start_dt TIMESTAMP,
    current_sbrcptn_end_dt TIMESTAMP,
    cancellation_decision_dt TIMESTAMP,
    cancellation_effective_dt TIMESTAMP,
    cancellation_reason VARCHAR(40),
    gokb_identifier INT,
    cancellation_candidate VARCHAR(1),
    materials_specified VARCHAR(200),
    first_indicator VARCHAR(20),
    second_indicator VARCHAR(20),
    created_by VARCHAR(40),
    date_created TIMESTAMP,
    updated_by VARCHAR(40),
    date_updated TIMESTAMP,
    CONSTRAINT PK_ole_ds_holdings_t PRIMARY KEY(holdings_id)
);

/*HoldingNote*/
CREATE TABLE local_ole.ole_ds_holdings_note_t (
    holdings_note_id INT NOT NULL,
    holdings_id INT NOT NULL,
    type VARCHAR(100),
    note TEXT,
    date_updated TIMESTAMP,
    CONSTRAINT PK_ole_ds_holdings_note_t PRIMARY KEY(holdings_note_id)
);

/*Item*/
CREATE TABLE local_ole.ole_ds_item_t (
    item_id INT NOT NULL,
    holdings_id INT NOT NULL,
    barcode VARCHAR(40),
    fast_add VARCHAR(1),
    staff_only VARCHAR(1),
    uri VARCHAR(400),
    item_type_id VARCHAR(40),
    temp_item_type_id VARCHAR(40),
    item_status_id VARCHAR(40),
    item_status_date_updated TIMESTAMP,
    location_id INT,
    location VARCHAR(600),
    location_level VARCHAR(600),
    call_number_type_id UUID,
    call_number_prefix VARCHAR(40),
    call_number VARCHAR(100),
    shelving_order VARCHAR(300),
    enumeration VARCHAR(100),
    chronology VARCHAR(100),
    copy_number VARCHAR(20),
    num_pieces VARCHAR(20),
    desc_of_pieces VARCHAR(400),
    purchase_order_line_item_id VARCHAR(45),
    vendor_line_item_id VARCHAR(45),
    fund VARCHAR(100),
    price DECIMAL(10,0),
    claims_returned VARCHAR(1),
    claims_returned_date_created TIMESTAMP,
    claims_returned_note VARCHAR(400),
    current_borrower VARCHAR(40),
    proxy_borrower VARCHAR(40),
    check_out_date_time TIMESTAMP,
    due_date_time TIMESTAMP,
    check_in_note VARCHAR(400),
    item_damaged_status VARCHAR(1),
    item_damaged_note VARCHAR(400),
    missing_pieces VARCHAR(1),
    missing_pieces_effective_date TIMESTAMP,
    missing_pieces_count INT,
    missing_pieces_note VARCHAR(400),
    barcode_arsl VARCHAR(200),
    high_density_storage_id INT,
    num_of_renew INT,
    created_by VARCHAR(40),
    date_created TIMESTAMP,
    updated_by VARCHAR(40),
    date_updated TIMESTAMP,
    unique_id_prefix VARCHAR(10),
    org_due_date_time TIMESTAMP,
    volume_number VARCHAR(100),
    CONSTRAINT PK_ole_ds_item_t PRIMARY KEY(item_id)
);

/*ItemNote*/
CREATE TABLE local_ole.ole_ds_item_note_t (
    item_note_id INT NOT NULL,
    item_id INT,
    type VARCHAR(50),
    note TEXT,
    date_updated TIMESTAMP,
    CONSTRAINT PK_ole_ds_item_note_t PRIMARY KEY(item_note_id)
);

/*ItemHolding*/
CREATE TABLE local_ole.ole_ds_item_holdings_t (
    item_holdings_id INT NOT NULL,
    holdings_id INT NOT NULL,
    item_id INT NOT NULL,
    date_updated TIMESTAMP,
    CONSTRAINT PK_ole_ds_item_holdings_t PRIMARY KEY(item_holdings_id)
);

/*RequestType*/
CREATE TABLE local_ole.ole_dlvr_rqst_typ_t (
    ole_rqst_typ_id VARCHAR(40) NOT NULL,
    ole_rqst_typ_cd VARCHAR(80) NOT NULL,
    ole_rqst_typ_nm VARCHAR(80) NOT NULL,
    row_act_ind VARCHAR(1) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    ole_rqst_typ_desc VARCHAR(80),
    CONSTRAINT PK_ole_dlvr_rqst_typ_t PRIMARY KEY(ole_rqst_typ_id)
);

/*Desk*/
CREATE TABLE local_ole.ole_crcl_dsk_t (
    ole_crcl_dsk_code VARCHAR(40) NOT NULL,
    ole_crcl_dsk_pub_name VARCHAR(100) NOT NULL,
    ole_crcl_dsk_staff_name VARCHAR(100) NOT NULL,
    actv_ind VARCHAR(1) NOT NULL,
    pk_up_locn_ind VARCHAR(1) NOT NULL,
    asr_pk_up_locn_ind VARCHAR(1) NOT NULL,
    hld_days DECIMAL(8,0),
    slvng_lag_tim DECIMAL(8,0),
    prnt_slp_ind VARCHAR(1) NOT NULL,
    ole_crcl_dsk_id VARCHAR(40) NOT NULL,
    ole_clndr_grp_id VARCHAR(40),
    hold_format VARCHAR(40),
    hold_queue VARCHAR(1) NOT NULL,
    reply_to_email VARCHAR(100),
    rqst_expirtin_days DECIMAL(8,0),
    staffed VARCHAR(1),
    renew_lost_itm VARCHAR(1),
    show_onhold_itm VARCHAR(50),
    dflt_rqst_typ_id VARCHAR(40),
    dflt_pick_up_locn_id VARCHAR(40),
    from_email VARCHAR(100),
    uc_obj_id VARCHAR(36),
    CONSTRAINT PK_ole_crcl_dsk_t PRIMARY KEY(ole_crcl_dsk_id)
);

/*DeskLocation*/
CREATE TABLE local_ole.ole_crcl_dsk_locn_t (
    ole_crcl_dsk_locn_id VARCHAR(40) NOT NULL,
    ole_crcl_dsk_id VARCHAR(40) NOT NULL,
    ole_crcl_dsk_locn VARCHAR(40) NOT NULL,
    ole_crcl_pickup_dsk_locn VARCHAR(40),
    locn_popup VARCHAR(1),
    locn_popup_msg TEXT,
    CONSTRAINT PK_ole_crcl_dsk_locn_t PRIMARY KEY(ole_crcl_dsk_locn_id)
);

/*DeskUser*/
CREATE TABLE local_ole.ole_circ_dsk_dtl_t (
    crcl_dsk_dtl_id VARCHAR(40) NOT NULL,
    optr_id VARCHAR(40),
    default_loc VARCHAR(1) NOT NULL,
    allowed_loc VARCHAR(1) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    crcl_dsk_id VARCHAR(40),
    CONSTRAINT PK_ole_circ_dsk_dtl_t PRIMARY KEY(crcl_dsk_dtl_id)
);

/*TemporaryLoan*/
CREATE TABLE local_ole.ole_dlvr_temp_circ_record (
    tmp_cir_his_rec_id VARCHAR(40) NOT NULL,
    ole_ptrn_id VARCHAR(40) NOT NULL,
    itm_id VARCHAR(40) NOT NULL,
    circ_loc_id VARCHAR(40) NOT NULL,
    check_in_dt_time TIMESTAMP,
    due_dt_time TIMESTAMP,
    check_out_dt_time TIMESTAMP,
    item_uuid VARCHAR(100) NOT NULL,
    ole_proxy_ptrn_id VARCHAR(40),
    uc_item_id INT,
    CONSTRAINT PK_ole_dlvr_temp_circ_record PRIMARY KEY(tmp_cir_his_rec_id)
);

/*PastLoan*/
CREATE TABLE local_ole.ole_dlvr_circ_record (
    cir_his_rec_id VARCHAR(40) NOT NULL,
    loan_tran_id VARCHAR(40) NOT NULL,
    cir_policy_id TEXT,
    ole_ptrn_id VARCHAR(40) NOT NULL,
    ptrn_typ_id VARCHAR(40),
    affiliation_id VARCHAR(40),
    department_id VARCHAR(40),
    other_affiliation VARCHAR(40),
    statistical_category VARCHAR(40),
    itm_id VARCHAR(40),
    bib_tit TEXT,
    bib_auth VARCHAR(500),
    bib_edition VARCHAR(500),
    bib_pub VARCHAR(500),
    bib_pub_dt TIMESTAMP,
    bib_isbn VARCHAR(50),
    proxy_ptrn_id VARCHAR(40),
    due_dt_time TIMESTAMP,
    past_due_dt_time TIMESTAMP,
    crte_dt_time TIMESTAMP NOT NULL,
    modi_dt_time TIMESTAMP,
    circ_loc_id VARCHAR(40) NOT NULL,
    optr_crte_id VARCHAR(40),
    optr_modi_id VARCHAR(40),
    mach_id VARCHAR(100),
    ovrr_optr_id VARCHAR(40),
    num_renewals VARCHAR(3),
    num_overdue_notices_sent VARCHAR(3),
    overdue_notice_date TIMESTAMP,
    ole_rqst_id VARCHAR(40),
    repmnt_fee_ptrn_bill_id VARCHAR(40),
    check_in_dt_time TIMESTAMP,
    check_in_optr_id VARCHAR(40),
    check_in_mach_id VARCHAR(100),
    item_uuid VARCHAR(100),
    itm_locn VARCHAR(100),
    hldng_locn VARCHAR(100),
    item_typ_id VARCHAR(100),
    temp_item_typ_id VARCHAR(100),
    check_in_dt_time_ovr_rd TIMESTAMP,
    uc_item_id INT,
    CONSTRAINT PK_ole_dlvr_circ_record PRIMARY KEY(cir_his_rec_id)
);

/*Return*/
CREATE TABLE local_ole.ole_return_history_t (
    id VARCHAR(40) NOT NULL,
    item_barcode VARCHAR(40),
    item_uuid VARCHAR(40),
    item_returned_dt TIMESTAMP,
    operator VARCHAR(40),
    cir_desk_loc VARCHAR(100),
    cir_desk_route_to VARCHAR(100),
    ver_nbr DECIMAL(8,0),
    obj_id VARCHAR(36),
    returned_item_status VARCHAR(200),
    uc_item_id INT,
    CONSTRAINT PK_ole_return_history_t PRIMARY KEY(id)
);

/*RecentReturn*/
CREATE TABLE local_ole.ole_dlvr_recently_returned_t (
    id VARCHAR(40) NOT NULL,
    circ_desk_id VARCHAR(40) NOT NULL,
    item_uuid VARCHAR(100) NOT NULL,
    uc_item_id INT,
    CONSTRAINT PK_ole_dlvr_recently_returned_t PRIMARY KEY(id)
);

/*FeeType*/
CREATE TABLE local_ole.ole_dlvr_ptrn_fee_type_t (
    fee_typ_id VARCHAR(40) NOT NULL,
    fee_typ_cd VARCHAR(40) NOT NULL,
    fee_typ_nm VARCHAR(40),
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    CONSTRAINT PK_ole_dlvr_ptrn_fee_type_t PRIMARY KEY(fee_typ_id)
);

/*PaymentStatus*/
CREATE TABLE local_ole.ole_ptrn_pay_sta_t (
    pay_sta_id VARCHAR(40) NOT NULL,
    pay_sta_code VARCHAR(40) NOT NULL,
    pay_sta_name VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    CONSTRAINT PK_ole_ptrn_pay_sta_t PRIMARY KEY(pay_sta_id)
);

/*PatronInvoice*/
CREATE TABLE local_ole.ole_dlvr_ptrn_bill_t (
    ptrn_bill_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36),
    ver_nbr DECIMAL(8,0),
    ole_ptrn_id VARCHAR(40),
    proxy_ptrn_id VARCHAR(40),
    tot_amt_due DECIMAL(10,4) NOT NULL,
    unpaid_bal DECIMAL(10,4),
    pay_method_id VARCHAR(40),
    pay_amt DECIMAL(10,4),
    pay_dt TIMESTAMP,
    pay_optr_id VARCHAR(40),
    pay_machine_id VARCHAR(40),
    crte_dt_time TIMESTAMP,
    optr_crte_id VARCHAR(40) NOT NULL,
    optr_machine_id VARCHAR(40),
    pay_note VARCHAR(500),
    note VARCHAR(500),
    bill_reviewed VARCHAR(1),
    crdt_issued DECIMAL(10,4),
    crdt_remaining DECIMAL(10,4),
    manual_bill VARCHAR(1),
    CONSTRAINT PK_ole_dlvr_ptrn_bill_t PRIMARY KEY(ptrn_bill_id)
);

/*PatronInvoiceItem*/
CREATE TABLE local_ole.ole_dlvr_ptrn_bill_fee_typ_t (
    id VARCHAR(40) NOT NULL,
    ptrn_bill_id VARCHAR(40) NOT NULL,
    itm_uuid VARCHAR(100),
    pay_status_id VARCHAR(40) NOT NULL,
    fee_typ_id VARCHAR(40) NOT NULL,
    fee_typ_amt DECIMAL(10,4) NOT NULL,
    itm_barcode VARCHAR(40),
    balance_amt DECIMAL(10,4),
    ptrn_bill_date TIMESTAMP NOT NULL,
    pay_forgive_note VARCHAR(500),
    pay_error_note VARCHAR(500),
    pay_cancel_note VARCHAR(500),
    pay_general_note VARCHAR(500),
    due_dt_time TIMESTAMP,
    check_out_dt_time TIMESTAMP,
    check_in_dt_time TIMESTAMP,
    operator_id VARCHAR(40),
    itm_title VARCHAR(600),
    itm_author VARCHAR(200),
    itm_type VARCHAR(100),
    itm_call_num VARCHAR(100),
    itm_copy_num VARCHAR(20),
    itm_enum VARCHAR(100),
    itm_chron VARCHAR(100),
    itm_loc VARCHAR(600),
    check_in_dt_time_ovr_rd TIMESTAMP,
    crdt_issued DECIMAL(10,4),
    crdt_remaining DECIMAL(10,4),
    pay_credit_note VARCHAR(500),
    pay_transfer_note VARCHAR(500),
    pay_refund_note VARCHAR(500),
    pay_can_crdt_note VARCHAR(500),
    manual_bill VARCHAR(1),
    rnwl_dt_time TIMESTAMP,
    uc_item_id INT,
    CONSTRAINT PK_ole_dlvr_ptrn_bill_fee_typ_t PRIMARY KEY(id)
);

/*Payment*/
CREATE TABLE local_ole.ole_dlvr_ptrn_bill_pay_t (
    id VARCHAR(40) NOT NULL,
    itm_line_id VARCHAR(40) NOT NULL,
    bill_pay_amt DECIMAL(10,4) NOT NULL,
    crte_dt_time TIMESTAMP NOT NULL,
    optr_crte_id VARCHAR(40) NOT NULL,
    trns_number VARCHAR(40),
    trns_note VARCHAR(500),
    trns_mode VARCHAR(40),
    note VARCHAR(500),
    CONSTRAINT PK_ole_dlvr_ptrn_bill_pay_t PRIMARY KEY(id)
);

/*Loan*/
CREATE TABLE local_ole.ole_dlvr_loan_t (
    loan_tran_id VARCHAR(40) NOT NULL,
    cir_policy_id TEXT,
    ole_ptrn_id VARCHAR(40) NOT NULL,
    itm_id VARCHAR(40),
    ole_proxy_borrower_nm VARCHAR(60),
    proxy_ptrn_id VARCHAR(40),
    curr_due_dt_time TIMESTAMP,
    past_due_dt_time TIMESTAMP,
    crte_dt_time TIMESTAMP NOT NULL,
    circ_loc_id VARCHAR(40) NOT NULL,
    optr_crte_id VARCHAR(40) NOT NULL,
    mach_id VARCHAR(100),
    ovrr_optr_id VARCHAR(40),
    num_renewals VARCHAR(3),
    num_overdue_notices_sent VARCHAR(3),
    n_overdue_notice VARCHAR(3),
    overdue_notice_date TIMESTAMP,
    ole_rqst_id VARCHAR(40),
    repmnt_fee_ptrn_bill_id VARCHAR(40),
    crtsy_ntce VARCHAR(1),
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    item_uuid VARCHAR(100) NOT NULL,
    num_claims_rtrn_notices_sent INT,
    claims_search_count INT,
    last_claims_rtrn_search_dt TIMESTAMP,
    uc_item_id INT,
    CONSTRAINT PK_ole_dlvr_loan_t PRIMARY KEY(loan_tran_id)
);

/*PastRequest*/
CREATE TABLE local_ole.ole_dlvr_rqst_hstry_rec_t (
    ole_rqst_hstry_id VARCHAR(40) NOT NULL,
    ole_rqst_id VARCHAR(40) NOT NULL,
    ole_item_id VARCHAR(80) NOT NULL,
    ole_loan_id VARCHAR(80),
    ole_ln_itm_num VARCHAR(80),
    ole_rqst_typ_cd VARCHAR(80) NOT NULL,
    ole_pck_loc_cd VARCHAR(80),
    ole_oprt_id VARCHAR(40) NOT NULL,
    ole_mach_id VARCHAR(80),
    arch_dt_time TIMESTAMP,
    obj_id VARCHAR(36) NOT NULL,
    ver_nbr DECIMAL(8,0) NOT NULL,
    ole_req_outcome_status VARCHAR(80),
    ole_ptrn_id VARCHAR(40),
    crte_dt_time TIMESTAMP NOT NULL,
    CONSTRAINT PK_ole_dlvr_rqst_hstry_rec_t PRIMARY KEY(ole_rqst_hstry_id)
);

/*Request*/
CREATE TABLE local_ole.ole_dlvr_rqst_t (
    ole_rqst_id VARCHAR(40) NOT NULL,
    obj_id VARCHAR(36),
    ver_nbr DECIMAL(8,0),
    po_ln_itm_no VARCHAR(100),
    itm_id VARCHAR(40),
    ole_ptrn_id VARCHAR(40),
    ole_ptrn_barcd VARCHAR(80),
    proxy_ptrn_id VARCHAR(40),
    proxy_ptrn_barcd VARCHAR(80),
    ole_rqst_typ_id VARCHAR(40),
    cntnt_desc TEXT,
    rqst_expir_dt_time TIMESTAMP,
    rcal_ntc_snt_dt TIMESTAMP,
    onhld_ntc_snt_dt TIMESTAMP,
    crte_dt_time TIMESTAMP NOT NULL,
    modi_dt_time TIMESTAMP,
    cpy_frmt VARCHAR(40),
    loan_tran_id VARCHAR(40),
    pckup_loc_id VARCHAR(40),
    optr_crte_id VARCHAR(40),
    optr_modi_id VARCHAR(40),
    circ_loc_id VARCHAR(40),
    mach_id VARCHAR(80),
    ptrn_q_pos INT,
    item_uuid VARCHAR(100) NOT NULL,
    rqst_stat VARCHAR(10),
    asr_flag VARCHAR(1),
    rqst_lvl VARCHAR(40),
    bib_id VARCHAR(40),
    hold_exp_date TIMESTAMP,
    rqst_note TEXT,
    uc_bib_id INT,
    uc_item_id INT,
    CONSTRAINT PK_ole_dlvr_rqst_t PRIMARY KEY(ole_rqst_id)
);

/*Person1*/
CREATE VIEW local_ole.uc_people AS
SELECT 
e.entity_id AS id, 
CONCAT_WS(' ', n.first_nm, n.middle_nm, n.last_nm) AS name,
n.first_nm AS first_name, 
n.middle_nm AS middle_name, 
n.last_nm AS last_name, 
ee.chicago_id, 
p.barcode AS library_id, 
ee.student_id, 
r.prncpl_nm AS user_name, 
m.email_addr AS email_address, 
p.activation_date,
p.expiration_date,
CASE WHEN p.actv_ind = 'Y' THEN true ELSE false END AS active,
CASE WHEN p.general_block = 'Y' THEN true ELSE false END AS general_block,
p.general_block_nt AS general_block_notes,
CASE WHEN p.paging_privilege = 'Y' THEN true ELSE false END AS paging_privilege,
CASE WHEN p.courtesy_notice = 'Y' THEN true ELSE false END AS courtesy_notice,
CASE WHEN p.delivery_privilege = 'Y' THEN true ELSE false END AS delivery_privilege,
s.ole_dlvr_src_id AS data_source_id,
s.ole_dlvr_src_nm AS data_source,
pt.dlvr_borr_typ_id AS patron_type_id,
pt.dlvr_borr_typ_nm AS patron_type,
pc.ole_dlvr_stat_cat_id AS patron_category_id,
pc.ole_dlvr_stat_cat_nm AS patron_category,
ee.status,
ee.statuses,
ee.staff_status,
ee.student_status,
ee.student_restriction,
ee.staff_privileges,
ee.staff_division,
ee.staff_department,
ee.student_division,
ee.student_department,
COALESCE(ee.deceased, false) AS deceased, 
COALESCE(ee.collections, false) AS collections, 
ee.creation_time,
ee.creation_user_name,
ee.last_write_time,
ee.last_write_user_name
FROM local_ole.krim_entity_t e
LEFT JOIN local_ole.ole_ptrn_t p ON e.entity_id = p.ole_ptrn_id 
LEFT JOIN local_ole.uc_entity_ext ee ON ee.id = e.entity_id
JOIN local_ole.krim_entity_nm_t n ON e.entity_id = n.entity_id
LEFT JOIN local_ole.krim_prncpl_t r ON e.entity_id = r.entity_id
LEFT JOIN local_ole.krim_entity_email_t m ON e.entity_id = m.entity_id
LEFT JOIN local_ole.ole_dlvr_stat_cat_t pc ON p.OLE_STAT_CAT = pc.OLE_DLVR_STAT_CAT_ID
LEFT JOIN local_ole.ole_dlvr_src_t s ON p.ole_src = s.ole_dlvr_src_id
LEFT JOIN local_ole.ole_dlvr_borr_typ_t pt ON p.borr_typ = pt.dlvr_borr_typ_id
WHERE m.dflt_ind IS NULL OR m.dflt_ind = 'Y';

ALTER TABLE local_ole.krlc_st_t ADD CONSTRAINT FK_krlc_st_t_krlc_cntry_t_postal_cntry_cd FOREIGN KEY(postal_cntry_cd) REFERENCES local_ole.krlc_cntry_t(postal_cntry_cd);
ALTER TABLE local_ole.krlc_pstl_cd_t ADD CONSTRAINT FK_krlc_pstl_cd_t_krlc_cntry_t_postal_cntry_cd FOREIGN KEY(postal_cntry_cd) REFERENCES local_ole.krlc_cntry_t(postal_cntry_cd);
ALTER TABLE local_ole.krlc_pstl_cd_t ADD CONSTRAINT FK_krlc_pstl_cd_t_krlc_st_t_postal_state_cd_postal_cntry_cd FOREIGN KEY(postal_state_cd, postal_cntry_cd) REFERENCES local_ole.krlc_st_t(postal_state_cd, postal_cntry_cd);
ALTER TABLE local_ole.krim_role_perm_t ADD CONSTRAINT FK_krim_role_perm_t_krim_role_t_role_id FOREIGN KEY(role_id) REFERENCES local_ole.krim_role_t(role_id);
ALTER TABLE local_ole.krim_entity_nm_t ADD CONSTRAINT FK_krim_entity_nm_t_krim_entity_t_entity_id FOREIGN KEY(entity_id) REFERENCES local_ole.krim_entity_t(entity_id) ON DELETE CASCADE;
ALTER TABLE local_ole.krim_entity_phone_t ADD CONSTRAINT FK_krim_entity_phone_t_krim_entity_t_entity_id FOREIGN KEY(entity_id) REFERENCES local_ole.krim_entity_t(entity_id);
ALTER TABLE local_ole.krim_entity_phone_t ADD CONSTRAINT FK_krim_entity_phone_t_krlc_cntry_t_postal_cntry_cd FOREIGN KEY(postal_cntry_cd) REFERENCES local_ole.krlc_cntry_t(postal_cntry_cd);
ALTER TABLE local_ole.krim_entity_email_t ADD CONSTRAINT FK_krim_entity_email_t_krim_entity_t_entity_id FOREIGN KEY(entity_id) REFERENCES local_ole.krim_entity_t(entity_id);
ALTER TABLE local_ole.krim_entity_addr_t ADD CONSTRAINT FK_krim_entity_addr_t_krim_entity_t_entity_id FOREIGN KEY(entity_id) REFERENCES local_ole.krim_entity_t(entity_id) ON DELETE CASCADE;
ALTER TABLE local_ole.krim_entity_addr_t ADD CONSTRAINT FK_krim_entity_addr_t_krlc_cntry_t_postal_cntry_cd FOREIGN KEY(postal_cntry_cd) REFERENCES local_ole.krlc_cntry_t(postal_cntry_cd);
ALTER TABLE local_ole.krim_entity_afltn_t ADD CONSTRAINT FK_krim_entity_afltn_t_krim_entity_t_entity_id FOREIGN KEY(entity_id) REFERENCES local_ole.krim_entity_t(entity_id) ON DELETE CASCADE;
ALTER TABLE local_ole.krim_entity_emp_info_t ADD CONSTRAINT FK_krim_entity_emp_info_t_krim_entity_t_entity_id FOREIGN KEY(entity_id) REFERENCES local_ole.krim_entity_t(entity_id) ON DELETE CASCADE;
ALTER TABLE local_ole.krim_entity_emp_info_t ADD CONSTRAINT FK_krim_entity_emp_info_t_krim_entity_afltn_t_entity_afltn_id FOREIGN KEY(entity_afltn_id) REFERENCES local_ole.krim_entity_afltn_t(entity_afltn_id);
ALTER TABLE local_ole.ole_ptrn_t ADD CONSTRAINT FK_ole_ptrn_t_krim_entity_t_ole_ptrn_id FOREIGN KEY(ole_ptrn_id) REFERENCES local_ole.krim_entity_t(entity_id);
ALTER TABLE local_ole.ole_ptrn_t ADD CONSTRAINT FK_ole_ptrn_t_ole_dlvr_borr_typ_t_borr_typ FOREIGN KEY(borr_typ) REFERENCES local_ole.ole_dlvr_borr_typ_t(dlvr_borr_typ_id);
ALTER TABLE local_ole.ole_ptrn_t ADD CONSTRAINT FK_ole_ptrn_t_ole_dlvr_src_t_ole_src FOREIGN KEY(ole_src) REFERENCES local_ole.ole_dlvr_src_t(ole_dlvr_src_id);
ALTER TABLE local_ole.ole_ptrn_t ADD CONSTRAINT FK_ole_ptrn_t_ole_dlvr_stat_cat_t_ole_stat_cat FOREIGN KEY(ole_stat_cat) REFERENCES local_ole.ole_dlvr_stat_cat_t(ole_dlvr_stat_cat_id);
ALTER TABLE local_ole.ole_ptrn_local_id_t ADD CONSTRAINT FK_ole_ptrn_local_id_t_ole_ptrn_t_ole_ptrn_id FOREIGN KEY(ole_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_proxy_ptrn_t ADD CONSTRAINT FK_ole_proxy_ptrn_t_ole_ptrn_id FOREIGN KEY(ole_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id) ON DELETE CASCADE;
ALTER TABLE local_ole.ole_dlvr_add_t ADD CONSTRAINT FK_ole_dlvr_add_t_ole_ptrn_t_ole_ptrn_id FOREIGN KEY(ole_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_dlvr_add_t ADD CONSTRAINT FK_ole_dlvr_add_t_krim_entity_addr_t_entity_addr_id FOREIGN KEY(entity_addr_id) REFERENCES local_ole.krim_entity_addr_t(entity_addr_id) ON DELETE CASCADE;
ALTER TABLE local_ole.ole_ptrn_nte_t ADD CONSTRAINT FK_ole_ptrn_nte_t_ole_ptrn_t_ole_ptrn_id FOREIGN KEY(ole_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_ptrn_nte_t ADD CONSTRAINT FK_ole_ptrn_nte_t_ole_ptrn_nte_typ_t_ole_ptrn_nte_typ_id FOREIGN KEY(ole_ptrn_nte_typ_id) REFERENCES local_ole.ole_ptrn_nte_typ_t(ole_ptrn_nte_typ_id);
ALTER TABLE local_ole.ole_ptrn_nte_t ADD CONSTRAINT FK_ole_ptrn_nte_t_krim_prncpl_t_optr_id FOREIGN KEY(optr_id) REFERENCES local_ole.krim_prncpl_t(prncpl_id);
ALTER TABLE local_ole.uc_entity_ext ADD CONSTRAINT FK_uc_entity_ext_krim_entity_t_id FOREIGN KEY(id) REFERENCES local_ole.krim_entity_t(entity_id) ON DELETE CASCADE;
ALTER TABLE local_ole.krim_prncpl_t ADD CONSTRAINT FK_krim_prncpl_t_krim_entity_t_entity_id FOREIGN KEY(entity_id) REFERENCES local_ole.krim_entity_t(entity_id) ON DELETE CASCADE;
ALTER TABLE local_ole.krim_role_mbr_t ADD CONSTRAINT FK_krim_role_mbr_t_krim_role_t_role_id FOREIGN KEY(role_id) REFERENCES local_ole.krim_role_t(role_id) ON DELETE CASCADE;
ALTER TABLE local_ole.krim_role_mbr_t ADD CONSTRAINT FK_krim_role_mbr_t_krim_prncpl_t_mbr_id FOREIGN KEY(mbr_id) REFERENCES local_ole.krim_prncpl_t(prncpl_id) ON DELETE CASCADE;
ALTER TABLE local_ole.ole_locn_t ADD CONSTRAINT FK_ole_locn_t_ole_locn_t_parent_locn_id FOREIGN KEY(parent_locn_id) REFERENCES local_ole.ole_locn_t(locn_id);
ALTER TABLE local_ole.ole_ds_bib_info_t ADD CONSTRAINT FK_ole_ds_bib_info_t_ole_ds_bib_t_bib_id FOREIGN KEY(bib_id) REFERENCES local_ole.ole_ds_bib_t(bib_id);
ALTER TABLE local_ole.ole_ds_holdings_t ADD CONSTRAINT FK_ole_ds_holdings_t_ole_ds_bib_t_bib_id FOREIGN KEY(bib_id) REFERENCES local_ole.ole_ds_bib_t(bib_id);
ALTER TABLE local_ole.ole_ds_holdings_note_t ADD CONSTRAINT FK_ole_ds_holdings_note_t_ole_ds_holdings_t_holdings_id FOREIGN KEY(holdings_id) REFERENCES local_ole.ole_ds_holdings_t(holdings_id);
ALTER TABLE local_ole.ole_ds_item_t ADD CONSTRAINT FK_ole_ds_item_t_ole_ds_holdings_t_holdings_id FOREIGN KEY(holdings_id) REFERENCES local_ole.ole_ds_holdings_t(holdings_id);
ALTER TABLE local_ole.ole_ds_item_t ADD CONSTRAINT FK_ole_ds_item_t_ole_ptrn_t_current_borrower FOREIGN KEY(current_borrower) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_ds_item_t ADD CONSTRAINT FK_ole_ds_item_t_ole_ptrn_t_proxy_borrower FOREIGN KEY(proxy_borrower) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_ds_item_note_t ADD CONSTRAINT FK_ole_ds_item_note_t_ole_ds_item_t_item_id FOREIGN KEY(item_id) REFERENCES local_ole.ole_ds_item_t(item_id);
ALTER TABLE local_ole.ole_ds_item_holdings_t ADD CONSTRAINT FK_ole_ds_item_holdings_t_ole_ds_holdings_t_holdings_id FOREIGN KEY(holdings_id) REFERENCES local_ole.ole_ds_holdings_t(holdings_id);
ALTER TABLE local_ole.ole_ds_item_holdings_t ADD CONSTRAINT FK_ole_ds_item_holdings_t_ole_ds_item_t_item_id FOREIGN KEY(item_id) REFERENCES local_ole.ole_ds_item_t(item_id);
ALTER TABLE local_ole.ole_crcl_dsk_t ADD CONSTRAINT FK_ole_crcl_dsk_t_ole_dlvr_rqst_typ_t_dflt_rqst_typ_id FOREIGN KEY(dflt_rqst_typ_id) REFERENCES local_ole.ole_dlvr_rqst_typ_t(ole_rqst_typ_id);
ALTER TABLE local_ole.ole_crcl_dsk_locn_t ADD CONSTRAINT FK_ole_crcl_dsk_locn_t_ole_crcl_dsk_t_ole_crcl_dsk_id FOREIGN KEY(ole_crcl_dsk_id) REFERENCES local_ole.ole_crcl_dsk_t(ole_crcl_dsk_id);
ALTER TABLE local_ole.ole_crcl_dsk_locn_t ADD CONSTRAINT FK_ole_crcl_dsk_locn_t_ole_locn_t_ole_crcl_dsk_locn FOREIGN KEY(ole_crcl_dsk_locn) REFERENCES local_ole.ole_locn_t(locn_id);
ALTER TABLE local_ole.ole_circ_dsk_dtl_t ADD CONSTRAINT FK_ole_circ_dsk_dtl_t_krim_prncpl_t_optr_id FOREIGN KEY(optr_id) REFERENCES local_ole.krim_prncpl_t(prncpl_id);
ALTER TABLE local_ole.ole_circ_dsk_dtl_t ADD CONSTRAINT FK_ole_circ_dsk_dtl_t_ole_crcl_dsk_t_crcl_dsk_id FOREIGN KEY(crcl_dsk_id) REFERENCES local_ole.ole_crcl_dsk_t(ole_crcl_dsk_id);
ALTER TABLE local_ole.ole_dlvr_rqst_hstry_rec_t ADD CONSTRAINT FK_ole_dlvr_rqst_hstry_rec_t_krim_prncpl_t_ole_oprt_id FOREIGN KEY(ole_oprt_id) REFERENCES local_ole.krim_prncpl_t(prncpl_id);
ALTER TABLE local_ole.ole_dlvr_rqst_hstry_rec_t ADD CONSTRAINT FK_ole_dlvr_rqst_hstry_rec_t_ole_ptrn_t_ole_ptrn_id FOREIGN KEY(ole_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_dlvr_rqst_t ADD CONSTRAINT FK_ole_dlvr_rqst_t_ole_ptrn_t_ole_ptrn_id FOREIGN KEY(ole_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_dlvr_rqst_t ADD CONSTRAINT FK_ole_dlvr_rqst_t_ole_ptrn_t_proxy_ptrn_id FOREIGN KEY(proxy_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_dlvr_rqst_t ADD CONSTRAINT FK_ole_dlvr_rqst_t_ole_dlvr_rqst_typ_t_ole_rqst_typ_id FOREIGN KEY(ole_rqst_typ_id) REFERENCES local_ole.ole_dlvr_rqst_typ_t(ole_rqst_typ_id);
ALTER TABLE local_ole.ole_dlvr_rqst_t ADD CONSTRAINT FK_ole_dlvr_rqst_t_ole_dlvr_loan_t_loan_tran_id FOREIGN KEY(loan_tran_id) REFERENCES local_ole.ole_dlvr_loan_t(loan_tran_id);
ALTER TABLE local_ole.ole_dlvr_rqst_t ADD CONSTRAINT FK_ole_dlvr_rqst_t_ole_crcl_dsk_t_pckup_loc_id FOREIGN KEY(pckup_loc_id) REFERENCES local_ole.ole_crcl_dsk_t(ole_crcl_dsk_id);
ALTER TABLE local_ole.ole_dlvr_rqst_t ADD CONSTRAINT FK_ole_dlvr_rqst_t_krim_prncpl_t_optr_crte_id FOREIGN KEY(optr_crte_id) REFERENCES local_ole.krim_prncpl_t(prncpl_id);
ALTER TABLE local_ole.ole_dlvr_rqst_t ADD CONSTRAINT FK_ole_dlvr_rqst_t_krim_prncpl_t_optr_modi_id FOREIGN KEY(optr_modi_id) REFERENCES local_ole.krim_prncpl_t(prncpl_id);
ALTER TABLE local_ole.ole_dlvr_rqst_t ADD CONSTRAINT FK_ole_dlvr_rqst_t_ole_crcl_dsk_t_circ_loc_id FOREIGN KEY(circ_loc_id) REFERENCES local_ole.ole_crcl_dsk_t(ole_crcl_dsk_id);
ALTER TABLE local_ole.ole_dlvr_rqst_t ADD CONSTRAINT FK_ole_dlvr_rqst_t_ole_ds_bib_t_uc_bib_id FOREIGN KEY(uc_bib_id) REFERENCES local_ole.ole_ds_bib_t(bib_id);
ALTER TABLE local_ole.ole_dlvr_rqst_t ADD CONSTRAINT FK_ole_dlvr_rqst_t_ole_ds_item_t_uc_item_id FOREIGN KEY(uc_item_id) REFERENCES local_ole.ole_ds_item_t(item_id);
ALTER TABLE local_ole.ole_dlvr_temp_circ_record ADD CONSTRAINT FK_ole_dlvr_temp_circ_record_ole_ptrn_t_ole_ptrn_id FOREIGN KEY(ole_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_dlvr_temp_circ_record ADD CONSTRAINT FK_ole_dlvr_temp_circ_record_ole_crcl_dsk_t_circ_loc_id FOREIGN KEY(circ_loc_id) REFERENCES local_ole.ole_crcl_dsk_t(ole_crcl_dsk_id);
ALTER TABLE local_ole.ole_dlvr_temp_circ_record ADD CONSTRAINT FK_ole_dlvr_temp_circ_record_ole_ptrn_t_ole_proxy_ptrn_id FOREIGN KEY(ole_proxy_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_dlvr_temp_circ_record ADD CONSTRAINT FK_ole_dlvr_temp_circ_record_ole_ds_item_t_uc_item_id FOREIGN KEY(uc_item_id) REFERENCES local_ole.ole_ds_item_t(item_id);
ALTER TABLE local_ole.ole_dlvr_circ_record ADD CONSTRAINT FK_ole_dlvr_circ_record_ole_ptrn_t_ole_ptrn_id FOREIGN KEY(ole_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_dlvr_circ_record ADD CONSTRAINT FK_ole_dlvr_circ_record_ole_dlvr_borr_typ_t_ptrn_typ_id FOREIGN KEY(ptrn_typ_id) REFERENCES local_ole.ole_dlvr_borr_typ_t(dlvr_borr_typ_id);
ALTER TABLE local_ole.ole_dlvr_circ_record ADD CONSTRAINT FK_ole_dlvr_circ_record_krim_entity_afltn_t_affiliation_id FOREIGN KEY(affiliation_id) REFERENCES local_ole.krim_entity_afltn_t(entity_afltn_id);
ALTER TABLE local_ole.ole_dlvr_circ_record ADD CONSTRAINT FK_ole_dlvr_circ_record_ole_dlvr_stat_cat_t_statistical_cate136 FOREIGN KEY(statistical_category) REFERENCES local_ole.ole_dlvr_stat_cat_t(ole_dlvr_stat_cat_id);
ALTER TABLE local_ole.ole_dlvr_circ_record ADD CONSTRAINT FK_ole_dlvr_circ_record_ole_ptrn_t_proxy_ptrn_id FOREIGN KEY(proxy_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
-- ALTER TABLE local_ole.ole_dlvr_circ_record ADD CONSTRAINT FK_ole_dlvr_circ_record_ole_crcl_dsk_t_circ_loc_id FOREIGN KEY(circ_loc_id) REFERENCES local_ole.ole_crcl_dsk_t(ole_crcl_dsk_id);
ALTER TABLE local_ole.ole_dlvr_circ_record ADD CONSTRAINT FK_ole_dlvr_circ_record_krim_prncpl_t_optr_crte_id FOREIGN KEY(optr_crte_id) REFERENCES local_ole.krim_prncpl_t(prncpl_id);
ALTER TABLE local_ole.ole_dlvr_circ_record ADD CONSTRAINT FK_ole_dlvr_circ_record_krim_prncpl_t_optr_modi_id FOREIGN KEY(optr_modi_id) REFERENCES local_ole.krim_prncpl_t(prncpl_id);
ALTER TABLE local_ole.ole_dlvr_circ_record ADD CONSTRAINT FK_ole_dlvr_circ_record_krim_entity_t_ovrr_optr_id FOREIGN KEY(ovrr_optr_id) REFERENCES local_ole.krim_entity_t(entity_id);
ALTER TABLE local_ole.ole_dlvr_circ_record ADD CONSTRAINT FK_ole_dlvr_circ_record_ole_dlvr_ptrn_bill_t_repmnt_fee_ptrn135 FOREIGN KEY(repmnt_fee_ptrn_bill_id) REFERENCES local_ole.ole_dlvr_ptrn_bill_t(ptrn_bill_id);
ALTER TABLE local_ole.ole_dlvr_circ_record ADD CONSTRAINT FK_ole_dlvr_circ_record_krim_prncpl_t_check_in_optr_id FOREIGN KEY(check_in_optr_id) REFERENCES local_ole.krim_prncpl_t(prncpl_id);
ALTER TABLE local_ole.ole_dlvr_circ_record ADD CONSTRAINT FK_ole_dlvr_circ_record_ole_ds_item_t_uc_item_id FOREIGN KEY(uc_item_id) REFERENCES local_ole.ole_ds_item_t(item_id);
ALTER TABLE local_ole.ole_dlvr_loan_t ADD CONSTRAINT FK_ole_dlvr_loan_t_ole_ptrn_t_ole_ptrn_id FOREIGN KEY(ole_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_dlvr_loan_t ADD CONSTRAINT FK_ole_dlvr_loan_t_ole_ptrn_t_proxy_ptrn_id FOREIGN KEY(proxy_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_dlvr_loan_t ADD CONSTRAINT FK_ole_dlvr_loan_t_ole_crcl_dsk_t_circ_loc_id FOREIGN KEY(circ_loc_id) REFERENCES local_ole.ole_crcl_dsk_t(ole_crcl_dsk_id);
ALTER TABLE local_ole.ole_dlvr_loan_t ADD CONSTRAINT FK_ole_dlvr_loan_t_krim_prncpl_t_optr_crte_id FOREIGN KEY(optr_crte_id) REFERENCES local_ole.krim_prncpl_t(prncpl_id);
ALTER TABLE local_ole.ole_dlvr_loan_t ADD CONSTRAINT FK_ole_dlvr_loan_t_krim_entity_t_ovrr_optr_id FOREIGN KEY(ovrr_optr_id) REFERENCES local_ole.krim_entity_t(entity_id);
ALTER TABLE local_ole.ole_dlvr_loan_t ADD CONSTRAINT FK_ole_dlvr_loan_t_ole_dlvr_rqst_t_ole_rqst_id FOREIGN KEY(ole_rqst_id) REFERENCES local_ole.ole_dlvr_rqst_t(ole_rqst_id);
ALTER TABLE local_ole.ole_dlvr_loan_t ADD CONSTRAINT FK_ole_dlvr_loan_t_ole_dlvr_ptrn_bill_t_repmnt_fee_ptrn_bill_id FOREIGN KEY(repmnt_fee_ptrn_bill_id) REFERENCES local_ole.ole_dlvr_ptrn_bill_t(ptrn_bill_id);
ALTER TABLE local_ole.ole_dlvr_loan_t ADD CONSTRAINT FK_ole_dlvr_loan_t_ole_ds_item_t_uc_item_id FOREIGN KEY(uc_item_id) REFERENCES local_ole.ole_ds_item_t(item_id);
ALTER TABLE local_ole.ole_return_history_t ADD CONSTRAINT FK_ole_return_history_t_krim_prncpl_t_operator FOREIGN KEY(operator) REFERENCES local_ole.krim_prncpl_t(prncpl_id);
ALTER TABLE local_ole.ole_return_history_t ADD CONSTRAINT FK_ole_return_history_t_ole_ds_item_t_uc_item_id FOREIGN KEY(uc_item_id) REFERENCES local_ole.ole_ds_item_t(item_id);
ALTER TABLE local_ole.ole_dlvr_recently_returned_t ADD CONSTRAINT FK_ole_dlvr_recently_returned_t_ole_crcl_dsk_t_circ_desk_id FOREIGN KEY(circ_desk_id) REFERENCES local_ole.ole_crcl_dsk_t(ole_crcl_dsk_id);
ALTER TABLE local_ole.ole_dlvr_recently_returned_t ADD CONSTRAINT FK_ole_dlvr_recently_returned_t_ole_ds_item_t_uc_item_id FOREIGN KEY(uc_item_id) REFERENCES local_ole.ole_ds_item_t(item_id);
ALTER TABLE local_ole.ole_dlvr_ptrn_bill_t ADD CONSTRAINT FK_ole_dlvr_ptrn_bill_t_ole_ptrn_t_ole_ptrn_id FOREIGN KEY(ole_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_dlvr_ptrn_bill_t ADD CONSTRAINT FK_ole_dlvr_ptrn_bill_t_ole_ptrn_t_proxy_ptrn_id FOREIGN KEY(proxy_ptrn_id) REFERENCES local_ole.ole_ptrn_t(ole_ptrn_id);
ALTER TABLE local_ole.ole_dlvr_ptrn_bill_t ADD CONSTRAINT FK_ole_dlvr_ptrn_bill_t_krim_prncpl_t_pay_optr_id FOREIGN KEY(pay_optr_id) REFERENCES local_ole.krim_prncpl_t(prncpl_id);
ALTER TABLE local_ole.ole_dlvr_ptrn_bill_fee_typ_t ADD CONSTRAINT FK_ole_dlvr_ptrn_bill_fee_typ_t_ole_dlvr_ptrn_bill_t_ptrn_bi137 FOREIGN KEY(ptrn_bill_id) REFERENCES local_ole.ole_dlvr_ptrn_bill_t(ptrn_bill_id);
ALTER TABLE local_ole.ole_dlvr_ptrn_bill_fee_typ_t ADD CONSTRAINT FK_ole_dlvr_ptrn_bill_fee_typ_t_ole_ptrn_pay_sta_t_pay_statu139 FOREIGN KEY(pay_status_id) REFERENCES local_ole.ole_ptrn_pay_sta_t(pay_sta_id);
ALTER TABLE local_ole.ole_dlvr_ptrn_bill_fee_typ_t ADD CONSTRAINT FK_ole_dlvr_ptrn_bill_fee_typ_t_ole_dlvr_ptrn_fee_type_t_fee138 FOREIGN KEY(fee_typ_id) REFERENCES local_ole.ole_dlvr_ptrn_fee_type_t(fee_typ_id);
ALTER TABLE local_ole.ole_dlvr_ptrn_bill_fee_typ_t ADD CONSTRAINT FK_ole_dlvr_ptrn_bill_fee_typ_t_krim_prncpl_t_operator_id FOREIGN KEY(operator_id) REFERENCES local_ole.krim_prncpl_t(prncpl_id);
ALTER TABLE local_ole.ole_dlvr_ptrn_bill_fee_typ_t ADD CONSTRAINT FK_ole_dlvr_ptrn_bill_fee_typ_t_ole_ds_item_t_uc_item_id FOREIGN KEY(uc_item_id) REFERENCES local_ole.ole_ds_item_t(item_id);
ALTER TABLE local_ole.ole_dlvr_ptrn_bill_pay_t ADD CONSTRAINT FK_ole_dlvr_ptrn_bill_pay_t_ole_dlvr_ptrn_bill_fee_typ_t_itm140 FOREIGN KEY(itm_line_id) REFERENCES local_ole.ole_dlvr_ptrn_bill_fee_typ_t(id);
ALTER TABLE local_ole.ole_dlvr_ptrn_bill_pay_t ADD CONSTRAINT FK_ole_dlvr_ptrn_bill_pay_t_krim_prncpl_t_optr_crte_id FOREIGN KEY(optr_crte_id) REFERENCES local_ole.krim_prncpl_t(prncpl_id);

CREATE INDEX fk_krlc_pstl_cd_t_postal_state_cd_postal_cntry_cd ON local_ole.krlc_pstl_cd_t(postal_state_cd, postal_cntry_cd);
CREATE INDEX fk_krim_role_perm_t_role_id ON local_ole.krim_role_perm_t(role_id);
CREATE INDEX fk_krim_entity_nm_t_entity_id ON local_ole.krim_entity_nm_t(entity_id);
CREATE INDEX fk_krim_entity_phone_t_entity_id ON local_ole.krim_entity_phone_t(entity_id);
CREATE INDEX fk_krim_entity_phone_t_postal_cntry_cd ON local_ole.krim_entity_phone_t(postal_cntry_cd);
CREATE INDEX fk_krim_entity_email_t_entity_id ON local_ole.krim_entity_email_t(entity_id);
CREATE INDEX fk_krim_entity_addr_t_entity_id ON local_ole.krim_entity_addr_t(entity_id);
CREATE INDEX fk_krim_entity_addr_t_postal_cntry_cd ON local_ole.krim_entity_addr_t(postal_cntry_cd);
CREATE INDEX fk_krim_entity_afltn_t_entity_id ON local_ole.krim_entity_afltn_t(entity_id);
CREATE INDEX fk_krim_entity_emp_info_t_entity_id ON local_ole.krim_entity_emp_info_t(entity_id);
CREATE INDEX fk_krim_entity_emp_info_t_entity_afltn_id ON local_ole.krim_entity_emp_info_t(entity_afltn_id);
CREATE INDEX fk_ole_ptrn_t_borr_typ ON local_ole.ole_ptrn_t(borr_typ);
CREATE INDEX fk_ole_ptrn_t_ole_src ON local_ole.ole_ptrn_t(ole_src);
CREATE INDEX fk_ole_ptrn_t_ole_stat_cat ON local_ole.ole_ptrn_t(ole_stat_cat);
CREATE INDEX fk_ole_ptrn_local_id_t_ole_ptrn_id ON local_ole.ole_ptrn_local_id_t(ole_ptrn_id);
CREATE INDEX fk_ole_proxy_ptrn_t_ole_ptrn_id ON local_ole.ole_proxy_ptrn_t(ole_ptrn_id);
CREATE INDEX fk_ole_dlvr_add_t_ole_ptrn_id ON local_ole.ole_dlvr_add_t(ole_ptrn_id);
CREATE INDEX fk_ole_dlvr_add_t_entity_addr_id ON local_ole.ole_dlvr_add_t(entity_addr_id);
CREATE INDEX fk_ole_ptrn_nte_t_ole_ptrn_id ON local_ole.ole_ptrn_nte_t(ole_ptrn_id);
CREATE INDEX fk_ole_ptrn_nte_t_ole_ptrn_nte_typ_id ON local_ole.ole_ptrn_nte_t(ole_ptrn_nte_typ_id);
CREATE INDEX fk_ole_ptrn_nte_t_optr_id ON local_ole.ole_ptrn_nte_t(optr_id);
CREATE INDEX fk_krim_prncpl_t_entity_id ON local_ole.krim_prncpl_t(entity_id);
CREATE INDEX fk_krim_role_mbr_t_role_id ON local_ole.krim_role_mbr_t(role_id);
CREATE INDEX fk_krim_role_mbr_t_mbr_id ON local_ole.krim_role_mbr_t(mbr_id);
CREATE INDEX fk_ole_locn_t_parent_locn_id ON local_ole.ole_locn_t(parent_locn_id);
CREATE INDEX fk_ole_ds_bib_info_t_bib_id ON local_ole.ole_ds_bib_info_t(bib_id);
CREATE INDEX fk_ole_ds_holdings_t_bib_id ON local_ole.ole_ds_holdings_t(bib_id);
CREATE INDEX fk_ole_ds_holdings_note_t_holdings_id ON local_ole.ole_ds_holdings_note_t(holdings_id);
CREATE INDEX fk_ole_ds_item_t_holdings_id ON local_ole.ole_ds_item_t(holdings_id);
CREATE INDEX fk_ole_ds_item_t_current_borrower ON local_ole.ole_ds_item_t(current_borrower);
CREATE INDEX fk_ole_ds_item_t_proxy_borrower ON local_ole.ole_ds_item_t(proxy_borrower);
CREATE INDEX fk_ole_ds_item_note_t_item_id ON local_ole.ole_ds_item_note_t(item_id);
CREATE INDEX fk_ole_ds_item_holdings_t_holdings_id ON local_ole.ole_ds_item_holdings_t(holdings_id);
CREATE INDEX fk_ole_ds_item_holdings_t_item_id ON local_ole.ole_ds_item_holdings_t(item_id);
CREATE INDEX fk_ole_crcl_dsk_t_dflt_rqst_typ_id ON local_ole.ole_crcl_dsk_t(dflt_rqst_typ_id);
CREATE INDEX fk_ole_crcl_dsk_locn_t_ole_crcl_dsk_id ON local_ole.ole_crcl_dsk_locn_t(ole_crcl_dsk_id);
CREATE INDEX fk_ole_crcl_dsk_locn_t_ole_crcl_dsk_locn ON local_ole.ole_crcl_dsk_locn_t(ole_crcl_dsk_locn);
CREATE INDEX fk_ole_circ_dsk_dtl_t_optr_id ON local_ole.ole_circ_dsk_dtl_t(optr_id);
CREATE INDEX fk_ole_circ_dsk_dtl_t_crcl_dsk_id ON local_ole.ole_circ_dsk_dtl_t(crcl_dsk_id);
CREATE INDEX fk_ole_dlvr_rqst_hstry_rec_t_ole_oprt_id ON local_ole.ole_dlvr_rqst_hstry_rec_t(ole_oprt_id);
CREATE INDEX fk_ole_dlvr_rqst_hstry_rec_t_ole_ptrn_id ON local_ole.ole_dlvr_rqst_hstry_rec_t(ole_ptrn_id);
CREATE INDEX fk_ole_dlvr_rqst_t_ole_ptrn_id ON local_ole.ole_dlvr_rqst_t(ole_ptrn_id);
CREATE INDEX fk_ole_dlvr_rqst_t_proxy_ptrn_id ON local_ole.ole_dlvr_rqst_t(proxy_ptrn_id);
CREATE INDEX fk_ole_dlvr_rqst_t_ole_rqst_typ_id ON local_ole.ole_dlvr_rqst_t(ole_rqst_typ_id);
CREATE INDEX fk_ole_dlvr_rqst_t_loan_tran_id ON local_ole.ole_dlvr_rqst_t(loan_tran_id);
CREATE INDEX fk_ole_dlvr_rqst_t_pckup_loc_id ON local_ole.ole_dlvr_rqst_t(pckup_loc_id);
CREATE INDEX fk_ole_dlvr_rqst_t_optr_crte_id ON local_ole.ole_dlvr_rqst_t(optr_crte_id);
CREATE INDEX fk_ole_dlvr_rqst_t_optr_modi_id ON local_ole.ole_dlvr_rqst_t(optr_modi_id);
CREATE INDEX fk_ole_dlvr_rqst_t_circ_loc_id ON local_ole.ole_dlvr_rqst_t(circ_loc_id);
CREATE INDEX fk_ole_dlvr_rqst_t_uc_bib_id ON local_ole.ole_dlvr_rqst_t(uc_bib_id);
CREATE INDEX fk_ole_dlvr_rqst_t_uc_item_id ON local_ole.ole_dlvr_rqst_t(uc_item_id);
CREATE INDEX fk_ole_dlvr_temp_circ_record_ole_ptrn_id ON local_ole.ole_dlvr_temp_circ_record(ole_ptrn_id);
CREATE INDEX fk_ole_dlvr_temp_circ_record_circ_loc_id ON local_ole.ole_dlvr_temp_circ_record(circ_loc_id);
CREATE INDEX fk_ole_dlvr_temp_circ_record_ole_proxy_ptrn_id ON local_ole.ole_dlvr_temp_circ_record(ole_proxy_ptrn_id);
CREATE INDEX fk_ole_dlvr_temp_circ_record_uc_item_id ON local_ole.ole_dlvr_temp_circ_record(uc_item_id);
CREATE INDEX fk_ole_dlvr_circ_record_ole_ptrn_id ON local_ole.ole_dlvr_circ_record(ole_ptrn_id);
CREATE INDEX fk_ole_dlvr_circ_record_ptrn_typ_id ON local_ole.ole_dlvr_circ_record(ptrn_typ_id);
CREATE INDEX fk_ole_dlvr_circ_record_affiliation_id ON local_ole.ole_dlvr_circ_record(affiliation_id);
CREATE INDEX fk_ole_dlvr_circ_record_statistical_category ON local_ole.ole_dlvr_circ_record(statistical_category);
CREATE INDEX fk_ole_dlvr_circ_record_proxy_ptrn_id ON local_ole.ole_dlvr_circ_record(proxy_ptrn_id);
CREATE INDEX fk_ole_dlvr_circ_record_circ_loc_id ON local_ole.ole_dlvr_circ_record(circ_loc_id);
CREATE INDEX fk_ole_dlvr_circ_record_optr_crte_id ON local_ole.ole_dlvr_circ_record(optr_crte_id);
CREATE INDEX fk_ole_dlvr_circ_record_optr_modi_id ON local_ole.ole_dlvr_circ_record(optr_modi_id);
CREATE INDEX fk_ole_dlvr_circ_record_ovrr_optr_id ON local_ole.ole_dlvr_circ_record(ovrr_optr_id);
CREATE INDEX fk_ole_dlvr_circ_record_repmnt_fee_ptrn_bill_id ON local_ole.ole_dlvr_circ_record(repmnt_fee_ptrn_bill_id);
CREATE INDEX fk_ole_dlvr_circ_record_check_in_optr_id ON local_ole.ole_dlvr_circ_record(check_in_optr_id);
CREATE INDEX fk_ole_dlvr_circ_record_uc_item_id ON local_ole.ole_dlvr_circ_record(uc_item_id);
CREATE INDEX fk_ole_dlvr_loan_t_ole_ptrn_id ON local_ole.ole_dlvr_loan_t(ole_ptrn_id);
CREATE INDEX fk_ole_dlvr_loan_t_proxy_ptrn_id ON local_ole.ole_dlvr_loan_t(proxy_ptrn_id);
CREATE INDEX fk_ole_dlvr_loan_t_circ_loc_id ON local_ole.ole_dlvr_loan_t(circ_loc_id);
CREATE INDEX fk_ole_dlvr_loan_t_optr_crte_id ON local_ole.ole_dlvr_loan_t(optr_crte_id);
CREATE INDEX fk_ole_dlvr_loan_t_ovrr_optr_id ON local_ole.ole_dlvr_loan_t(ovrr_optr_id);
CREATE INDEX fk_ole_dlvr_loan_t_ole_rqst_id ON local_ole.ole_dlvr_loan_t(ole_rqst_id);
CREATE INDEX fk_ole_dlvr_loan_t_repmnt_fee_ptrn_bill_id ON local_ole.ole_dlvr_loan_t(repmnt_fee_ptrn_bill_id);
CREATE INDEX fk_ole_dlvr_loan_t_uc_item_id ON local_ole.ole_dlvr_loan_t(uc_item_id);
CREATE INDEX fk_ole_return_history_t_operator ON local_ole.ole_return_history_t(operator);
CREATE INDEX fk_ole_return_history_t_uc_item_id ON local_ole.ole_return_history_t(uc_item_id);
CREATE INDEX fk_ole_dlvr_recently_returned_t_circ_desk_id ON local_ole.ole_dlvr_recently_returned_t(circ_desk_id);
CREATE INDEX fk_ole_dlvr_recently_returned_t_uc_item_id ON local_ole.ole_dlvr_recently_returned_t(uc_item_id);
CREATE INDEX fk_ole_dlvr_ptrn_bill_t_ole_ptrn_id ON local_ole.ole_dlvr_ptrn_bill_t(ole_ptrn_id);
CREATE INDEX fk_ole_dlvr_ptrn_bill_t_proxy_ptrn_id ON local_ole.ole_dlvr_ptrn_bill_t(proxy_ptrn_id);
CREATE INDEX fk_ole_dlvr_ptrn_bill_t_pay_optr_id ON local_ole.ole_dlvr_ptrn_bill_t(pay_optr_id);
CREATE INDEX fk_ole_dlvr_ptrn_bill_fee_typ_t_ptrn_bill_id ON local_ole.ole_dlvr_ptrn_bill_fee_typ_t(ptrn_bill_id);
CREATE INDEX fk_ole_dlvr_ptrn_bill_fee_typ_t_pay_status_id ON local_ole.ole_dlvr_ptrn_bill_fee_typ_t(pay_status_id);
CREATE INDEX fk_ole_dlvr_ptrn_bill_fee_typ_t_fee_typ_id ON local_ole.ole_dlvr_ptrn_bill_fee_typ_t(fee_typ_id);
CREATE INDEX fk_ole_dlvr_ptrn_bill_fee_typ_t_operator_id ON local_ole.ole_dlvr_ptrn_bill_fee_typ_t(operator_id);
CREATE INDEX fk_ole_dlvr_ptrn_bill_fee_typ_t_uc_item_id ON local_ole.ole_dlvr_ptrn_bill_fee_typ_t(uc_item_id);
CREATE INDEX fk_ole_dlvr_ptrn_bill_pay_t_itm_line_id ON local_ole.ole_dlvr_ptrn_bill_pay_t(itm_line_id);
CREATE INDEX fk_ole_dlvr_ptrn_bill_pay_t_optr_crte_id ON local_ole.ole_dlvr_ptrn_bill_pay_t(optr_crte_id);

CREATE INDEX krlc_cntry_t_postal_cntry_nm ON local_ole.krlc_cntry_t(postal_cntry_nm);
CREATE INDEX krlc_cntry_t_actv_ind ON local_ole.krlc_cntry_t(actv_ind);
CREATE INDEX krlc_st_t_postal_state_nm ON local_ole.krlc_st_t(postal_state_nm);
CREATE INDEX krlc_st_t_actv_ind ON local_ole.krlc_st_t(actv_ind);
CREATE INDEX krlc_pstl_cd_t_actv_ind ON local_ole.krlc_pstl_cd_t(actv_ind);
CREATE INDEX krms_rule_t_nm ON local_ole.krms_rule_t(nm);
CREATE INDEX krms_rule_t_actv ON local_ole.krms_rule_t(actv);
CREATE INDEX krim_role_t_role_nm ON local_ole.krim_role_t(role_nm);
CREATE INDEX krim_role_t_actv_ind ON local_ole.krim_role_t(actv_ind);
CREATE INDEX krim_role_t_last_updt_dt ON local_ole.krim_role_t(last_updt_dt DESC);
CREATE INDEX krim_role_perm_t_actv_ind ON local_ole.krim_role_perm_t(actv_ind);
CREATE INDEX ole_dlvr_src_t_ole_dlvr_src_nm ON local_ole.ole_dlvr_src_t(ole_dlvr_src_nm);
CREATE INDEX ole_dlvr_src_t_row_act_ind ON local_ole.ole_dlvr_src_t(row_act_ind);
CREATE INDEX ole_dlvr_borr_typ_t_dlvr_borr_typ_nm ON local_ole.ole_dlvr_borr_typ_t(dlvr_borr_typ_nm);
CREATE INDEX ole_dlvr_borr_typ_t_row_act_ind ON local_ole.ole_dlvr_borr_typ_t(row_act_ind);
CREATE INDEX ole_dlvr_stat_cat_t_ole_dlvr_stat_cat_nm ON local_ole.ole_dlvr_stat_cat_t(ole_dlvr_stat_cat_nm);
CREATE INDEX ole_dlvr_stat_cat_t_row_act_ind ON local_ole.ole_dlvr_stat_cat_t(row_act_ind);
CREATE INDEX ole_ptrn_nte_typ_t_ole_ptrn_nte_typ_nm ON local_ole.ole_ptrn_nte_typ_t(ole_ptrn_nte_typ_nm);
CREATE INDEX ole_ptrn_nte_typ_t_actv_ind ON local_ole.ole_ptrn_nte_typ_t(actv_ind);
CREATE INDEX krim_entity_t_actv_ind ON local_ole.krim_entity_t(actv_ind);
CREATE INDEX krim_entity_t_last_updt_dt ON local_ole.krim_entity_t(last_updt_dt DESC);
CREATE INDEX krim_entity_nm_t_first_nm ON local_ole.krim_entity_nm_t(first_nm);
CREATE INDEX krim_entity_nm_t_actv_ind ON local_ole.krim_entity_nm_t(actv_ind);
CREATE INDEX krim_entity_nm_t_last_updt_dt ON local_ole.krim_entity_nm_t(last_updt_dt DESC);
CREATE INDEX krim_entity_phone_t_phone_nbr ON local_ole.krim_entity_phone_t(phone_nbr);
CREATE INDEX krim_entity_phone_t_actv_ind ON local_ole.krim_entity_phone_t(actv_ind);
CREATE INDEX krim_entity_phone_t_last_updt_dt ON local_ole.krim_entity_phone_t(last_updt_dt DESC);
CREATE INDEX krim_entity_email_t_email_addr ON local_ole.krim_entity_email_t(email_addr);
CREATE INDEX krim_entity_email_t_actv_ind ON local_ole.krim_entity_email_t(actv_ind);
CREATE INDEX krim_entity_email_t_last_updt_dt ON local_ole.krim_entity_email_t(last_updt_dt DESC);
CREATE INDEX krim_entity_addr_t_addr_line_1 ON local_ole.krim_entity_addr_t(addr_line_1);
CREATE INDEX krim_entity_addr_t_state_pvc_cd ON local_ole.krim_entity_addr_t(state_pvc_cd);
CREATE INDEX krim_entity_addr_t_actv_ind ON local_ole.krim_entity_addr_t(actv_ind);
CREATE INDEX krim_entity_addr_t_last_updt_dt ON local_ole.krim_entity_addr_t(last_updt_dt DESC);
CREATE INDEX krim_entity_afltn_t_actv_ind ON local_ole.krim_entity_afltn_t(actv_ind);
CREATE INDEX krim_entity_afltn_t_last_updt_dt ON local_ole.krim_entity_afltn_t(last_updt_dt DESC);
CREATE INDEX krim_entity_emp_info_t_actv_ind ON local_ole.krim_entity_emp_info_t(actv_ind);
CREATE INDEX krim_entity_emp_info_t_last_updt_dt ON local_ole.krim_entity_emp_info_t(last_updt_dt DESC);
CREATE INDEX ole_ptrn_t_barcode ON local_ole.ole_ptrn_t(barcode);
CREATE INDEX ole_ptrn_t_actv_ind ON local_ole.ole_ptrn_t(actv_ind);
CREATE INDEX ole_dlvr_add_t_add_valid_from ON local_ole.ole_dlvr_add_t(add_valid_from);
CREATE INDEX ole_ptrn_nte_t_actv_ind ON local_ole.ole_ptrn_nte_t(actv_ind);
CREATE INDEX ole_ptrn_nte_t_nte_crt_or_updt_date ON local_ole.ole_ptrn_nte_t(nte_crt_or_updt_date DESC);
CREATE INDEX uc_entity_ext_last_write_time ON local_ole.uc_entity_ext(last_write_time DESC);
CREATE INDEX uc_entity_ext_student_id_idx ON local_ole.uc_entity_ext USING btree (student_id);
CREATE INDEX krim_prncpl_t_prncpl_nm ON local_ole.krim_prncpl_t(prncpl_nm);
CREATE INDEX krim_prncpl_t_actv_ind ON local_ole.krim_prncpl_t(actv_ind);
CREATE INDEX krim_prncpl_t_last_updt_dt ON local_ole.krim_prncpl_t(last_updt_dt DESC);
CREATE INDEX krim_role_mbr_t_last_updt_dt ON local_ole.krim_role_mbr_t(last_updt_dt DESC);
CREATE INDEX ole_cat_shvlg_schm_t_shvlg_schm_nm ON local_ole.ole_cat_shvlg_schm_t(shvlg_schm_nm);
CREATE INDEX ole_cat_shvlg_schm_t_row_act_ind ON local_ole.ole_cat_shvlg_schm_t(row_act_ind);
CREATE INDEX ole_cat_shvlg_schm_t_date_updated ON local_ole.ole_cat_shvlg_schm_t(date_updated DESC);
CREATE INDEX ole_dlvr_item_avail_stat_t_item_avail_stat_nm ON local_ole.ole_dlvr_item_avail_stat_t(item_avail_stat_nm);
CREATE INDEX ole_dlvr_item_avail_stat_t_row_act_ind ON local_ole.ole_dlvr_item_avail_stat_t(row_act_ind);
CREATE INDEX ole_dlvr_item_avail_stat_t_date_updated ON local_ole.ole_dlvr_item_avail_stat_t(date_updated DESC);
CREATE INDEX ole_cat_itm_typ_t_itm_typ_nm ON local_ole.ole_cat_itm_typ_t(itm_typ_nm);
CREATE INDEX ole_cat_itm_typ_t_row_act_ind ON local_ole.ole_cat_itm_typ_t(row_act_ind);
CREATE INDEX ole_cat_itm_typ_t_date_updated ON local_ole.ole_cat_itm_typ_t(date_updated DESC);
CREATE INDEX ole_locn_t_locn_name ON local_ole.ole_locn_t(locn_name);
CREATE INDEX ole_locn_t_row_act_ind ON local_ole.ole_locn_t(row_act_ind);
CREATE INDEX ole_ds_bib_t_fast_add ON local_ole.ole_ds_bib_t(fast_add);
CREATE INDEX ole_ds_bib_t_staff_only ON local_ole.ole_ds_bib_t(staff_only);
CREATE INDEX ole_ds_bib_t_created_by ON local_ole.ole_ds_bib_t(created_by);
CREATE INDEX ole_ds_bib_t_date_created ON local_ole.ole_ds_bib_t(date_created);
CREATE INDEX ole_ds_bib_t_updated_by ON local_ole.ole_ds_bib_t(updated_by);
CREATE INDEX ole_ds_bib_t_date_updated ON local_ole.ole_ds_bib_t(date_updated DESC);
CREATE INDEX ole_ds_bib_t_status ON local_ole.ole_ds_bib_t(status);
CREATE INDEX ole_ds_bib_t_status_updated_by ON local_ole.ole_ds_bib_t(status_updated_by);
CREATE INDEX ole_ds_bib_t_status_updated_date ON local_ole.ole_ds_bib_t(status_updated_date);
CREATE INDEX ole_ds_bib_t_unique_id_prefix ON local_ole.ole_ds_bib_t(unique_id_prefix);
CREATE INDEX ole_ds_bib_info_t_date_updated ON local_ole.ole_ds_bib_info_t(date_updated DESC);
CREATE INDEX ole_ds_holdings_t_holdings_type ON local_ole.ole_ds_holdings_t(holdings_type);
CREATE INDEX ole_ds_holdings_t_date_updated ON local_ole.ole_ds_holdings_t(date_updated DESC);
CREATE INDEX ole_ds_holdings_note_t_date_updated ON local_ole.ole_ds_holdings_note_t(date_updated DESC);
CREATE INDEX ole_ds_item_t_barcode ON local_ole.ole_ds_item_t(barcode);
CREATE INDEX ole_ds_item_t_date_updated ON local_ole.ole_ds_item_t(date_updated DESC);
CREATE INDEX ole_ds_item_note_t_date_updated ON local_ole.ole_ds_item_note_t(date_updated DESC);
CREATE INDEX ole_ds_item_holdings_t_date_updated ON local_ole.ole_ds_item_holdings_t(date_updated DESC);
CREATE INDEX ole_crcl_dsk_t_ole_crcl_dsk_pub_name ON local_ole.ole_crcl_dsk_t(ole_crcl_dsk_pub_name);
CREATE INDEX ole_crcl_dsk_t_actv_ind ON local_ole.ole_crcl_dsk_t(actv_ind);
CREATE INDEX ole_dlvr_rqst_typ_t_ole_rqst_typ_nm ON local_ole.ole_dlvr_rqst_typ_t(ole_rqst_typ_nm);
CREATE INDEX ole_dlvr_rqst_typ_t_row_act_ind ON local_ole.ole_dlvr_rqst_typ_t(row_act_ind);
CREATE INDEX ole_dlvr_rqst_t_modi_dt_time ON local_ole.ole_dlvr_rqst_t(modi_dt_time DESC);
CREATE INDEX ole_dlvr_loan_t_crte_dt_time ON local_ole.ole_dlvr_loan_t(crte_dt_time DESC);
CREATE INDEX ole_return_history_t_item_returned_dt ON local_ole.ole_return_history_t(item_returned_dt DESC);
CREATE INDEX ole_dlvr_ptrn_fee_type_t_fee_typ_nm ON local_ole.ole_dlvr_ptrn_fee_type_t(fee_typ_nm);
CREATE INDEX ole_ptrn_pay_sta_t_pay_sta_name ON local_ole.ole_ptrn_pay_sta_t(pay_sta_name);
CREATE INDEX ole_dlvr_ptrn_bill_t_crte_dt_time ON local_ole.ole_dlvr_ptrn_bill_t(crte_dt_time DESC);
CREATE INDEX ole_dlvr_ptrn_bill_pay_t_crte_dt_time ON local_ole.ole_dlvr_ptrn_bill_pay_t(crte_dt_time DESC);
