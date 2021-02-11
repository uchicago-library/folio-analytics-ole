DROP TABLE IF EXISTS local_ole.uc_people;
SELECT 
u.id::uuid AS id, 
CONCAT_WS(' ', u.data#>>'{personal,firstName}', u.data#>>'{personal,middleName}', u.data#>>'{personal,lastName}') AS name,
u.data#>>'{personal,firstName}' AS first_name, 
u.data#>>'{personal,middleName}' AS middle_name, 
u.data#>>'{personal,lastName}' AS last_name, 
u.data->>'externalSystemId' AS chicago_id, 
u.data->>'barcode' AS library_id, 
u.data#>>'{customFields,studentId}' AS student_id, 
u.data->>'username' AS user_name, 
u.data#>>'{personal,email}' AS email_address, 
(u.data->>'enrollmentDate')::timestamp with time zone AS activation_date,
(u.data->>'expirationDate')::timestamp with time zone AS expiration_date,
(u.data->>'active')::boolean AS active,
NULL AS general_block,
NULL AS general_block_notes,
NULL AS paging_privilege,
NULL AS courtesy_notice,
NULL AS delivery_privilege,
NULL AS data_source_id,
u.data#>>'{customFields,source}' AS data_source,
(u.data->>'patronGroup')::uuid AS patron_type_id,
g.data->>'group' AS patron_type,
NULL AS patron_category_id,
u.data#>>'{customFields,category}' AS patron_category,
u.data#>>'{customFields,status}' AS status,
u.data#>>'{customFields,statuses}' AS statuses,
u.data#>>'{customFields,staffStatus}' AS staff_status,
u.data#>>'{customFields,studentStatus}' AS student_status,
u.data#>>'{customFields,studentRestriction}' AS student_restriction,
u.data#>>'{customFields,staffPrivileges}' AS staff_privileges,
u.data#>>'{customFields,staffDivision}' AS staff_division,
u.data#>>'{customFields,staffDepartment}' AS staff_department,
u.data#>>'{customFields,studentDivision}' AS student_division,
u.data#>>'{customFields,studentDepartment}' AS student_department,
(u.data#>>'{customFields,deceased}')::boolean AS deceased, 
(u.data#>>'{customFields,collections}')::boolean AS collections, 
(u.data#>>'{metadata,createdDate}')::timestamp with time zone AS creation_time,
u2.data->>'username' AS creation_user_name,
(u.data#>>'{metadata,updatedDate}')::timestamp with time zone AS last_write_time,
u3.data->>'username' AS last_write_user_name
INTO local_ole.uc_people
FROM user_users u
LEFT JOIN user_groups g ON g.id = u.data->>'patronGroup'
LEFT JOIN user_users u2 ON u2.id = u.data#>>'{metadata,createdByUserId}'
LEFT JOIN user_users u3 ON u3.id = u.data#>>'{metadata,updatedByUserId}'
;
