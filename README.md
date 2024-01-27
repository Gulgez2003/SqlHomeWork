# Adding Category and Product 
---
## Stored Procedure: `sp_CheckCategoryAndAddProduct`

### Purpose
This stored procedure (`sp_CheckCategoryAndAddProduct`) is designed to add a product to the Northwind database while ensuring that the associated category for the product exists. If the specified category does not exist, it will be added before inserting the product.

### Parameters
- `@categoryName` (NVARCHAR(15)): The name of the category for the product.
- `@description` (NTEXT): The description of the category.
- `@productName` (NVARCHAR(40)): The name of the product.
- `@unitPrice` (MONEY): The unit price of the product.
- `@unitsInStock` (SMALLINT): The number of units in stock for the product.

### Procedure Logic
1. **Check Category Existence**: The procedure checks if the specified category (`@categoryName`) already exists in the `Categories` table.
2. **Add Category if Not Exist**: If the category does not exist, it is added to the `Categories` table with the provided name and description.
3. **Add Product**: After ensuring the existence of the category, the product details are inserted into the `Products` table with the associated category ID.

### Error Handling
- The procedure includes a `TRY...CATCH` block to capture and handle any errors that may occur during execution.
- In case of an error, a message is printed indicating the nature of the error using `ERROR_MESSAGE()`.

### Usage
To use the stored procedure, execute it with the required parameters. For example:

```sql
EXECUTE sp_CheckCategoryAndAddProduct 
    @categoryName = 'TestCategory2', 
    @description = 'TestDescription2', 
    @productName = 'TestProduct3',
    @unitPrice = 4,
    @unitsInStock = 4
```
# Checking and Adding Category
---
## Stored Procedure: `sp_CheckAndAddCategory`

### Purpose
This stored procedure (`sp_CheckAndAddCategory`) is designed to check if a specified category exists in the Northwind database. If the category does not exist, it is added to the `Categories` table.

### Parameters
- `@category` (NVARCHAR(15)): The name of the category to be checked and added.

### Procedure Logic
1. **Check Category Existence**: The procedure checks if the specified category (`@category`) already exists in the `Categories` table.
2. **Add Category if Not Exist**: If the category does not exist, it is added to the `Categories` table with the provided name.
3. **Print Message on Existence**: If the category already exists, a message is printed indicating that the category is already in the database.

### Error Handling
- The procedure includes a `TRY...CATCH` block to capture and handle any errors that may occur during execution.
- In case of an error, a message is printed indicating the nature of the error using `ERROR_MESSAGE()`.

### Usage
To use the stored procedure, execute it with the required parameters. For example:

```sql
EXECUTE sp_CheckAndAddCategory @category = 'Test'
```
# Checking Location (Country, City, Town, District)
---
## Database Schema: `Location`

This script creates a database schema named `Location` with tables `Country`, `City`, `Town`, and `District` to represent a hierarchical location structure. The provided stored procedure `sp_CheckAndAddLocation` is designed to check and add entries for countries, cities, towns, and districts within the database, ensuring data integrity.

### Tables

1. **Country Table:**
   - `Id` (INT): Primary key, auto-incremented.
   - `CountryName` (VARCHAR(50)): Name of the country.

2. **City Table:**
   - `Id` (INT): Primary key, auto-incremented.
   - `CityName` (VARCHAR(50)): Name of the city.
   - `CountryId` (INT): Foreign key referencing the `Country` table.

3. **Town Table:**
   - `Id` (INT): Primary key, auto-incremented.
   - `TownName` (VARCHAR(50)): Name of the town.
   - `CityId` (INT): Foreign key referencing the `City` table.

4. **District Table:**
   - `Id` (INT): Primary key, auto-incremented.
   - `DistrictName` (VARCHAR(50)): Name of the district.
   - `TownId` (INT): Foreign key referencing the `Town` table.

### Stored Procedure: `sp_CheckAndAddLocation`

#### Purpose
The stored procedure `sp_CheckAndAddLocation` checks if a country, city, town, and district already exist in the database. If they do not exist, the stored procedure adds them, ensuring data consistency and referential integrity.

#### Parameters
- `@country` (VARCHAR(50)): Name of the country.
- `@city` (VARCHAR(50)): Name of the city.
- `@town` (VARCHAR(50)): Name of the town.
- `@district` (VARCHAR(50)): Name of the district.

#### Procedure Logic
1. **Check Country Existence**: If the specified country does not exist, it is added to the `Country` table.
2. **Check City Existence**: If the specified city does not exist in the specified country, it is added to the `City` table.
3. **Check Town Existence**: If the specified town does not exist in the specified city, it is added to the `Town` table.
4. **Check District Existence**: If the specified district does not exist in the specified town, it is added to the `District` table.

#### Error Handling
- The procedure includes a `TRY...CATCH` block to capture and handle any errors that may occur during execution.
- In case of an error, a message is printed indicating the nature of the error using `ERROR_MESSAGE()`.

#### Usage
To use the stored procedure, execute it with the required parameters. For example:

```sql
EXECUTE sp_CheckAndAddLocation 
    @country = 'Japan', 
    @city = 'Tokyo', 
    @town = 'Shibuya', 
    @district = 'Harajuku'
```
