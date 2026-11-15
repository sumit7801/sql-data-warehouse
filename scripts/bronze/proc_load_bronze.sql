-- Creating Store Procedure for Bronze Layer

/*
=============================================================
Stored Procedure : Load Bronze Layer (Source -> Bronze)

Usage Example : EXEC bronze.load_bronze;
=============================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN

  DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

	BEGIN TRY
	  SET @batch_start_time = GETDATE();
		PRINT '========================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '========================================================';


		-- Now Load the data from Source System to Datawarehouse by BULK INSERT.
		-- WRITE SQL BULK INSERT TO LOAD ALL CSV FILES INTO YOUR BRONZE TABLES.


		PRINT '--------------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '--------------------------------------------------------';

	    SET @start_time = GETDATE();
		PRINT '>> Truncating Table : bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;     -- TRUNCATE WILL DELETE THE WHOLE TABLE DATA and make it empty.

		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,                            -- It will skip the first row, because first row is not actual data, its column information.
			FIELDTERMINATOR = ',',                   -- We are using FIELDTERMINATOR for seperating the feilds on the basis of separator, or delimiter.
			TABLOCK                                  -- TABLOCK lock the table during loading.
		);

		-- check the qulity of data in the table by using select
		-- Quality Check : Check that the data has not shifted and is in the correct columns AND number of row are same as in source system.

		--SELECT * FROM Bronze.crm_cust_info;
		--SELECT COUNT(*) FROM Bronze.crm_cust_info;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR);


		SET @start_time = GETDATE();
		-- Load data for bronze.crm_prd_info
		PRINT '>> Truncating Table : bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;  
	
		PRINT '>> Inserting Data Into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,                            
			FIELDTERMINATOR = ',',                   
			TABLOCK                                  
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR);


		SET @start_time = GETDATE();
		-- Load data for bronze.crm_sales_details
		PRINT '>> Truncating Table : bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;  
	
		PRINT '>> Inserting Data Into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,                            
			FIELDTERMINATOR = ',',                   
			TABLOCK                                  
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR);



		PRINT '--------------------------------------------------------'
		PRINT 'Loading ERP Tables'
		PRINT '--------------------------------------------------------'


		SET @start_time = GETDATE();
		-- Load data for bronze.erp_cust_az12
		PRINT '>> Truncating Table : bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
	
		PRINT '>> Inserting Data Into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,                            
			FIELDTERMINATOR = ',',                   
			TABLOCK                                  
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR);


		SET @start_time = GETDATE();
		-- Load data for bronze.erp_loc_a101
		PRINT '>> Truncating Table : bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;  
	
		PRINT '>> Inserting Data Into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,                            
			FIELDTERMINATOR = ',',                   
			TABLOCK                                  
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR);


		SET @start_time = GETDATE();
		-- Load data for bronze.erp_px_cat_g1v2
		PRINT '>> Truncating Table : bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;   
	
		PRINT '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\sql-data-warehouse-project (1)\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,                            
			FIELDTERMINATOR = ',',                   
			TABLOCK                                  
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration : ' + CAST (DATEDIFF(second, @start_time, @end_time) AS NVARCHAR);

		SET @batch_end_time = GETDATE();
		PRINT 'Loading Bronze Layer is Completed';
	    PRINT 'Total Load Duration : ' + CAST (DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';

	END TRY
	BEGIN CATCH
	PRINT '======================================================='
	PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
	PRINT 'Error Message : ' + ERROR_MESSAGE();
	PRINT 'Error Message : ' + CAST (ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error Message : ' + CAST (ERROR_STATE() AS NVARCHAR);
	PRINT '======================================================='
	END CATCH


END;

/* HINT : Save frequently used SQL code in stored procedures in database */
