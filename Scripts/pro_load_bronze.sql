/*
===================================================================================================
Stored Procedure : Load Bronze Layer (source -> Bronze)
===================================================================================================
Script Purpose :
  This stored procedure loads data into the 'bronze' schema from external CSV files.
  It performs the following actions :
    - Truncates the bronze table before loading data.
    - Uses the 'BULK INSERT' command to load data from csv to bronze tables.
Paremeters:
  None.
This stored procedure does not accept any parameters or return any values.
Usage Example:
  EXEC bronze.load_bronze;
===================================================================================================
*/

create or alter procedure bronze.load_bronze as 
begin
	declare @start_time datetime , @end_time datetime;
	declare @bronze_start_time datetime, @bronze_end_time datetime;
	begin try

		set @bronze_start_time = getdate();
		print '====================================================================================';
		print 'Loading Bronze Layer ';
		print '====================================================================================';
		print '------------------------------------------------------------------------------------';
		print 'Loading CRM Tables';
		print '------------------------------------------------------------------------------------';
		
		set @start_time = getdate();
		PRINT '>> Truncating Table:bronze.crm_cust_info ' ;
		truncate table bronze.crm_cust_info;
		print 'Inserting Data Into :bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'C:\Users\PETER\Desktop\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'>> Load Duration :' + cast (datediff(second,@start_time, @end_time) as nvarchar) + 'seconds';
		print '----------------';

		set @start_time = getdate();
		PRINT '>> Truncating Table:bronze.crm_prd_info ' ;
		truncate table bronze.crm_prd_info;
		print 'Inserting Data Into :bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from 'C:\Users\PETER\Desktop\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second,@start_time, @end_time) as nvarchar );
		print '----------------';
		
		set @start_time = getdate();
		PRINT '>> Truncating Table:bronze.crm_sls_ord_num' ;
		truncate table bronze.crm_sls_ord_num;
		print 'Inserting Data Into :bronze.crm_sls_ord_num'
		bulk insert bronze.crm_sls_ord_num
		from 'C:\Users\PETER\Desktop\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second,@start_time, @end_time) as nvarchar );
		print '----------------'

		print '------------------------------------------------------------------------------------';
		print 'Loading ERP Tables';
		print '------------------------------------------------------------------------------------';

		set @start_time = getdate();
		PRINT '>> Truncating Table:bronze.erp_cust_az12';
		truncate table bronze.erp_cust_az12;
		print 'Inserting Data Into :bronze.erp_cust_az12'
		bulk insert bronze.erp_cust_az12
		from 'C:\Users\PETER\Desktop\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second,@start_time, @end_time) as nvarchar );
		print '----------------'

		set @start_time = getdate();
		PRINT '>> Truncating Table:bronze.erp_loc_a101 ';
		truncate table bronze.erp_loc_a101;
		print 'Inserting Data Into :bronze.erp_loc_a101'
		bulk insert bronze.erp_loc_a101
		from 'C:\Users\PETER\Desktop\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with (
			firstrow = 2,
			fieldterminator =',',
			tablock
		);
		set @end_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second,@start_time, @end_time) as nvarchar );
		print '----------------'

		set @start_time = getdate ();
		PRINT '>> Truncating Table:bronze.erp_px_cat_g1v2 ' ;
		truncate table bronze.erp_px_cat_g1v2;
		print 'Inserting Data Into :bronze.erp_px_cat_g1v2'
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\Users\PETER\Desktop\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @start_time = getdate();
		print '>> Load Duration: ' + cast(datediff(second,@start_time, @end_time) as nvarchar );
		print '----------------'

		set @bronze_end_time = getdate();
		print '>> Bronze Load Duration: ' + cast(datediff(second,@bronze_start_time, @bronze_end_time) as nvarchar ) + 'seconds';
		print '----------------'
	end try

	begin catch
	print '====================================================================================';
	print 'Error Occured During Loading Bronze Layer'
	print 'Error Message' + ERROR_MESSAGE();
	print 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
	print 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
	print '====================================================================================';
	end catch
end
