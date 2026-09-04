/*
==============================================================================
DDLScript : Create Bronze Tables
==============================================================================
Script Purpose:
  This script creates tables in the 'bronze' schema, dropping existing tables 
  if they exist.
  Running this script re-defines the DDL-structure of 'bronze' Tables
=============================================================================
*/
if OBJECT_ID ('bronze.crm_cust_info' ,  'u') is not null
	DROp TABLE bronze.crm_cust_info ;
CREATE TABLE bronze.crm_cust_info (
	cst_id              int,
	cst_key             nvarchar (50),
	cst_firstname       nvarchar (50),
	cst_lastname        nvarchar (50),
	cst_material_status nvarchar (50),
	cst_gndr            nvarchar (50),
	cst_create_date     date
);

if OBJECT_ID ('bronze.crm_prd_id' ,  'u') is not null
	DROp TABLE bronze.crm_prd_id ;
create table bronze.crm_prd_id(
	prd_id       int,
	prd_key      nvarchar (50),
	prd_nm       nvarchar (50),
	prd_cost     int,
	prd_line     nvarchar (50),
	prd_start_dt datetime,
	prd_end_dt   datetime
);
if OBJECT_ID ('bronze.crm_sls_ord_num' ,  'u') is not null
	DROp TABLE bronze.crm_sls_ord_num ;
create table bronze.crm_sls_ord_num(
	sls_ord_num  nvarchar (50),
	sls_prd_key  nvarchar (50),
	sls_cust_id  int,
	sls_order_dt int,
	sls_ship_dt  int,
	sls_due_dt   int,
	sls_sales    int,
	sls_quantity int,
	sls_price    int
);
if OBJECT_ID ('bronze.erp_cust_az12' ,  'u') is not null
	DROp TABLE bronze.erp_cust_az12 ;
create table bronze.erp_cust_az12(
	cid   nvarchar (50),
	bdate date,
	gen   nvarchar(50)

);
if OBJECT_ID ('bronze.erp_cust_a101' ,  'u') is not null
	DROp TABLE bronze.erp_cust_a101 ;
create table bronze.erp_cust_a101(
	cid   nvarchar (50),
	cntry nvarchar(50)
);
if OBJECT_ID ('bronze.erp_px_cat_g1v2' ,  'u') is not null
	DROp TABLE bronze.erp_px_cat_g1v2 ;
create table bronze.erp_px_cat_g1v2(
	id        nvarchar (50),
	cat       nvarchar (50),
	subcat    nvarchar (50),
	maintence nvarchar (50)
);
