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
--=============================================================================
-- Checking silver.crm_prd_info
--=============================================================================
-- Quality Checks
-- Check for nulls or duplicates in primary key
-- Expectation : No result
select
prd_id,
count(*)
from silver.crm_prd_info
group by prd_id
having count(*) > 1 or prd_id is null

-- Check for unwanted spaces
-- Expectation : No results
select 
prd_nm
from silver.crm_prd_info
where prd_nm != trim(prd_nm)

--check for nulls or negative numbers
-- expectation : no results
select 
prd_cost
from silver.crm_prd_info
where prd_cost < 0 or prd_cost is null

-- data standardization & consistency
select 
distinct prd_line
from silver.crm_prd_info

--check for invaild date orders
select *
from silver.crm_prd_info
where prd_end_dt < prd_start_dt

--=======================================================================
-- Check for silver.crm_sales_details
--=======================================================================
--checking for invalide order dates
-- check for invalid dates
select
nullif(sls_due_dt,0) sls_due_dt
from silver.crm_sales_details
where sls_due_dt <= 0
or len(sls_due_dt) != 8
or sls_due_dt > 20500101
or sls_due_dt < 19000101

select
*
from silver.crm_sales_details
where sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt

--data standardization & consistency
select distinct
sls_sales,
sls_quantity,
sls_price 
from silver.crm_sales_details
where sls_sales!=sls_quantity * sls_price or sls_sales is null
or sls_quantity is null or sls_price is null or sls_sales <= 0
or sls_quantity <=0or sls_price <=0
--=============================================================
--check for silver.erp_cust_az12
--=============================================================
--identify out-of-range dates
select distinct
bdate
from silver.erp_cust_az12
where bdate < '1924-01-01' or bdate > getdate()

--data standardization & consistency
select distinct
gen
from silver.erp_cust_az12

--==============================================================
--check for silver.erp_loc_a101
--==============================================================
select
distinct cntry
from silver.erp_loc_a101
order by cntrys

--==============================================================
--check for silver.erp_px_cat_g1v2
--==============================================================
--identify out-of-range dates
select distinct
bdate
from silver.erp_cust_az12
where bdate < '1924-01-01' or bdate > getdate()

-- check for unwanted spaces
select
*
from silver.erp_px_cat_g1v2
where cat != trim(cat) or subcat != trim(subcat) or maintenance != trim(maintenance)

--data standardization & consistency
select distinct
gen
from silver.erp_cust_az12
