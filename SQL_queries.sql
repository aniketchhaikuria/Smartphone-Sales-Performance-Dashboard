
1. **Fetching Sample Data:**
   ```sql
   SELECT * 
   FROM `durable-epoch-418201.smartphone_sales.sales` 
   LIMIT 10;
   ```
   - This query retrieves the first 10 rows from the `sales` table to preview the data.

2. **Retrieving Schema Information:**
   ```sql
   SELECT 
     column_name, 
     data_type 
   FROM 
     `durable-epoch-418201.smartphone_sales.INFORMATION_SCHEMA.COLUMNS` 
   WHERE 
     table_name = 'sales';
   ```
   - This query lists the names and data types of all columns in the `sales` table to understand its structure.

3. **Counting Missing Values in Each Column:**
   ```sql
   SELECT 
     COUNTIF(Brands IS NULL) AS Missing_Brands,
     COUNTIF(Models IS NULL) AS Missing_Models,
     COUNTIF(Colors IS NULL) AS Missing_Colors,
     COUNTIF(Memory IS NULL) AS Missing_Memory,
     COUNTIF(Storage IS NULL) AS Missing_Storage,
     COUNTIF(Camera IS NULL) AS Missing_Camera,
     COUNTIF(Rating IS NULL) AS Missing_Rating,
     COUNTIF(`Selling Price` IS NULL) AS Missing_Selling_Price,
     COUNTIF(`Original Price` IS NULL) AS Missing_Original_Price,
     COUNTIF(Mobile IS NULL) AS Missing_Mobile,
     COUNTIF(Discount IS NULL) AS Missing_Discount,
     COUNTIF(`discount percentage` IS NULL) AS Missing_Discount_Percentage
   FROM `durable-epoch-418201.smartphone_sales.sales`;
   ```
   - This query counts the number of missing (NULL) values in each specified column of the `sales` table to assess data completeness.

4. **Removing Rows with Missing Selling Price:**
   ```sql
   CREATE OR REPLACE TABLE `durable-epoch-418201.smartphone_sales.sales` AS 
   SELECT *
   FROM `durable-epoch-418201.smartphone_sales.sales`
   WHERE `Selling Price` IS NOT NULL;
   ```
   - This query creates a new version of the `sales` table by keeping only rows where the `Selling Price` is not NULL, thereby cleaning the data.

5. **Filling Missing Memory and Storage:**
   ```sql
   CREATE OR REPLACE TABLE `durable-epoch-418201.smartphone_sales.sales` AS 
   SELECT
     *,
     IFNULL(Memory, 'Unknown') AS Cleaned_Memory,
     IFNULL(Storage, 'Unknown') AS Cleaned_Storage
   FROM `durable-epoch-418201.smartphone_sales.sales`;
   ```
   - This query adds new columns (`Cleaned_Memory` and `Cleaned_Storage`) that replace NULL values in `Memory` and `Storage` with 'Unknown'.

6. **Standardizing Text Fields:**
   ```sql
   CREATE OR REPLACE TABLE `durable-epoch-418201.smartphone_sales.sales` AS 
   SELECT 
     *,
     UPPER(Brands) AS Standardized_Brands,
     UPPER(Models) AS Standardized_Models,
     UPPER(Colors) AS Standardized_Colors
   FROM `durable-epoch-418201.smartphone_sales.sales`;
   ```
   - This query creates new columns with standardized (uppercase) values for `Brands`, `Models`, and `Colors`.

7. **Removing Duplicate Rows:**
   ```sql
   CREATE OR REPLACE TABLE `durable-epoch-418201.smartphone_sales.sales` AS 
   SELECT DISTINCT *
   FROM `durable-epoch-418201.smartphone_sales.sales`;
   ```
   - This query removes duplicate rows from the `sales` table by selecting distinct records.

8. **Calculating Total Revenue:**
   ```sql
   SELECT 
     SUM(`Selling Price`) AS TotalRevenue 
   FROM `durable-epoch-418201.smartphone_sales.sales`;
   ```
   - This query calculates the total revenue by summing up the `Selling Price` column.

9. **Calculating Average Rating:**
   ```sql
   SELECT 
     AVG(Rating) AS AverageRating 
   FROM `durable-epoch-418201.smartphone_sales.sales`;
   ```
   - This query computes the average of the `Rating` column.

10. **Calculating Average Discount Percentage:**
    ```sql
    SELECT
      AVG(`discount percentage`) AS AverageDiscountPercentage
    FROM `durable-epoch-418201.smartphone_sales.sales`;
    ```
    - This query calculates the average discount percentage across all records.

11. **Aggregating Sales and Revenue by Brand:**
    ```sql
    SELECT
      UPPER(Brands) AS Brand,
      COUNT(*) AS TotalSales,
      SUM(`Selling Price`) AS TotalRevenue
    FROM `durable-epoch-418201.smartphone_sales.sales`
    GROUP BY 
      Brands
    ORDER BY
      TotalSales DESC;
    ```
    - This query groups the data by `Brands`, counts the total sales, and sums the revenue for each brand, ordering by total sales in descending order.

12. **Aggregating Sales and Revenue by Memory and Storage:**
    ```sql
    SELECT 
      Memory,
      Storage,
      COUNT(*) AS TotalSales,
      SUM(`Selling Price`) AS TotalRevenue
    FROM `durable-epoch-418201.smartphone_sales.sales`
    GROUP BY 
      Memory, Storage
    ORDER BY
      TotalSales DESC;
    ```
    - This query groups the data by `Memory` and `Storage`, counts the total sales, and sums the revenue for each combination, ordered by total sales in descending order.

13. **Calculating Average Rating and Total Sales by Brand and Model:**
    ```sql
    SELECT 
      UPPER(Brands) AS Brand,
      Models AS Model,
      AVG(Rating) AS AverageRating,
      COUNT(*) AS TotalSales
    FROM 
      `durable-epoch-418201.smartphone_sales.sales`
    GROUP BY 
      Brands, Models
    ORDER BY 
      Brand, AverageRating DESC;
    ```
    - This query groups the data by `Brands` and `Models`, calculates the average rating and counts the total sales for each combination, and orders by brand and average rating in descending order.

14. **Calculating Average Discount Percentage Again:**
    ```sql
    SELECT 
      AVG(`discount percentage`) AS AverageDiscountPercentage
    FROM 
      `durable-epoch-418201.smartphone_sales.sales`;
    ```
    - This query again computes the average of the `discount percentage` column.

15. **Calculating Top 10 Models by Average Discount Percentage:**
    ```sql
    SELECT
      Upper(Brands) AS Brand,
      Models AS Model,
      AVG(`discount percentage`) AS AverageDiscountPercentage,
      COUNT(*) AS TotalSales
    FROM `durable-epoch-418201.smartphone_sales.sales`
    GROUP BY
      Brands, Models
    ORDER BY
      AverageDiscountPercentage DESC
    LIMIT 10;
    ```
    - This query selects the top 10 combinations of `Brands` and `Models` with the highest average discount percentage, counting total sales and grouping by brands and models.

16. **Aggregating Total Revenue by Brand:**
    ```sql
    SELECT
      Brands AS Brand,
      SUM(`Selling Price`) AS TotalRevenue
    FROM `durable-epoch-418201.smartphone_sales.sales`
    GROUP BY
      Brands;
    ```
    - This query groups the data by `Brands` and sums the `Selling Price` to get the total revenue for each brand.

17. **Counting Total Sales by Brand:**
    ```sql
    SELECT
      Brands AS Brand,
      COUNT(*) AS TotalSales
    FROM `durable-epoch-418201.smartphone_sales.sales`
    GROUP BY
      Brands;
    ```
    - This query groups the data by `Brands` and counts the number of sales for each brand.