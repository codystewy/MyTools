# KACE notes 
## SQL Queries
#### Use case: 
Try to get a view that contains all the information to tie a custom field type to the custom field properties that are used when dragging and dropping the custom fields into the Ticket Template layout.
#### Attempted SQL and notes needed to get there
1. Tables Needed
	- HD_TICKET_TEMPLATE
		- `select ID as TemplateID, QUEUE_ID, TEMPLATE_NAME, DESCRIPTION, CREATED, MODIFIED from HD_TICKET_TEMPLATE`
	- HD_QUEUE
		- `select NAME as Q_NAME,TICKET_PREFIX as Q_TICKET_PREFIX, ID AS Q_ID from HD_QUEUE`
	- HD_TICKET_TEMPLATE_FIELD
		- `SELECT HTTF.TICKET_TEMPLATE_ID AS "Template ID", HTTF.FIELD_NAME AS "Field Name" FROM HD_TICKET_TEMPLATE_FIELD AS HTTF`
	- HD_CUSTOM_FIELDS
		- `SELECT HCF.ID AS "Custom Field ID", HCF.NAME AS "Custom Field Name", HCF.TYPE AS "Custom Field Type", HCF.VALUES AS	"Custom Field Values", HCF.DEFAULT AS "Custom Field Default" FROM HD_CUSTOM_FIELDS AS HCF`

#### All that combined
`select HQ.NAME AS "Queue Name", HTT.TEMPLATE_NAME as "Template Name",HTTF.FIELD_NAME AS "Field Name", HTTF.VISIBILITY_CONDITIONS AS "Visibility Conditions",
HTTF.OTHER_ATTRIBUTES as "Other Attributes", HCF.ID AS "Custom Field ID", HCF.NAME AS "Custom Field Name", HCF.TYPE AS "Custom Field Type", HCF.VALUES AS	"Custom Field Values", HCF.DEFAULT AS "Custom Field Default"
FROM HD_QUEUE AS HQ
INNER JOIN HD_TICKET_TEMPLATE AS HTT
ON HQ.ID = HTT.QUEUE_ID
INNER JOIN HD_TICKET_TEMPLATE_FIELD AS HTTF
ON HTTF.TICKET_TEMPLATE_ID = HTT.ID
INNER JOIN HD_CUSTOM_FIELDS HCF
ON HCF.HD_QUEUE_ID = HQ.ID
WHERE HQ.NAME = 'Customer Service'

ORDER BY HTT.ID`
