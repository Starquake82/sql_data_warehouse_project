/*
===========================================================================================================
STORED PROCEDURE: LOAD BRONZE LAYER (Source -> Bronze)
===========================================================================================================

Script Purpose:
	This stored procedure loads data into the 'bronze' schema from external CSV files.
	
	It performs following actions:
	- Truncates the bronze tables before loading data.
	- Uses 'BULK INSERT' command to load data from CSV files to bronze tables.

	Parameters:
	- None

	Usage Example:
	- EXECUTE bronze.load_bronze

------------------------------------------------------------------------------------------------------------

*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;

	BEGIN TRY

		SET @batch_start_time = GETDATE();

		PRINT	'==========================================================================================';
		PRINT	'Loading Bronze Layer...';
		PRINT	'==========================================================================================';

		PRINT	'------------------------------------------------------------------------------------------';
		PRINT	'Loading CRM Tables...';
		PRINT	'------------------------------------------------------------------------------------------';

		SET @start_time = GETDATE();

		TRUNCATE TABLE	bronze.crm_cust_info;

		BULK INSERT	bronze.crm_cust_info
		FROM		'F:\My Folder\Learning Hub\Business Intelligence\Courses\Data with Baraa YouTube - SQL Course Mastery\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH	(
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
				);
		
		SET @end_time = GETDATE();
		PRINT	'>> Load Duration bronze.crm_cust_info: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';



		SET @start_time = GETDATE();

		TRUNCATE TABLE	bronze.crm_prd_info

		BULK INSERT	bronze.crm_prd_info
		FROM		'F:\My Folder\Learning Hub\Business Intelligence\Courses\Data with Baraa YouTube - SQL Course Mastery\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH		(
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
					);
		SET @end_time = GETDATE();
		PRINT	'>> Load Duration bronze.crm_prd_info: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';



		SET @start_time = GETDATE();
		TRUNCATE TABLE	bronze.crm_sales_details;
	
		BULK INSERT	bronze.crm_sales_details
		FROM		'F:\My Folder\Learning Hub\Business Intelligence\Courses\Data with Baraa YouTube - SQL Course Mastery\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH		(
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
					);

		SET @end_time = GETDATE();
		PRINT	'>> Load Duration bronze.crm_sales_details: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

		-----------------------------------------------------------------------------------------------------

		PRINT	'------------------------------------------------------------------------------------------';
		PRINT	'Loading CRM Tables...';
		PRINT	'------------------------------------------------------------------------------------------';

		SET @start_time = GETDATE();

		TRUNCATE TABLE	bronze.erp_cust_az12;

		BULK INSERT	bronze.erp_cust_az12
		FROM		'F:\My Folder\Learning Hub\Business Intelligence\Courses\Data with Baraa YouTube - SQL Course Mastery\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH		(
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
					);
		
		SET @end_time = GETDATE();
		PRINT	'>> Load Duration bronze.erp_cust_az12: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';



		SET @start_time = GETDATE();

		TRUNCATE TABLE	bronze.erp_loc_a101;

		BULK INSERT	bronze.erp_loc_a101
		FROM		'F:\My Folder\Learning Hub\Business Intelligence\Courses\Data with Baraa YouTube - SQL Course Mastery\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH		(
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
					);

		SET @end_time = GETDATE();
		PRINT	'>> Load Duration bronze.erp_loc_a101: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';




		SET @start_time = GETDATE();

		TRUNCATE TABLE	bronze.erp_px_cat_g1v2;

		BULK INSERT	bronze.erp_px_cat_g1v2
		FROM		'F:\My Folder\Learning Hub\Business Intelligence\Courses\Data with Baraa YouTube - SQL Course Mastery\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH		(
					FIRSTROW = 2,
					FIELDTERMINATOR = ',',
					TABLOCK
					);
		
		SET @end_time = GETDATE();
		
		PRINT	'>> Load Duration bronze.erp_px_cat_g1v2: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	
		PRINT	'------------------------------------------------------------------------------------------';
		PRINT	'' -- Blank Line
		PRINT	'Loading Bronze Layer Completed.';

		SET @batch_end_time = GETDATE();
		PRINT	'>> Total Batch Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';

	END TRY

	BEGIN CATCH
		PRINT	'==========================================================================================';
		PRINT	'ERROR OCCURED DURING LOADING THE BRONZE LAYER';
		PRINT	'Error Message' + ERROR_MESSAGE();
		PRINT	'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT	'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT	'==========================================================================================';
	END CATCH

END
