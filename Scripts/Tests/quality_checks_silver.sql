/*
===========================================================================
Quality Checks
===========================================================================
Script Purpose:
	This script performs various quality checks for data consistency, accuracy,
	and standardization across the 'silver ' schema. it includes checks for:
	- Null or duplicate primary keys.
	- Unwanted spaces in string fields.
	- Data standardization and consistency.
	- invalid data ranges and orders.
	- Data consistency between related fields.
Usage Notes:
	- Run these checks after data loading silver layer.
	- investigate and resolve any discrepancies found during the checks.
===========================================================================
*/
--==========================================================================
-- checking 'silver.crm_cust_info'
--==========================================================================
select 
	cst_id,
	count(*)
From silver.crm_cust_info
group by cst_id
having count(*) > 1 or cst_id is null
