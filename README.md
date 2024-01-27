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

