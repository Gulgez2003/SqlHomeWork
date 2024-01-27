USE Northwind

ALTER PROCEDURE sp_CheckCategoryAndAddProduct
    @categoryName NVARCHAR(15),
	@description NTEXT,
	@productName NVARCHAR(40),
	@unitPrice MONEY,
	@unitsInStock SMALLINT
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = @categoryName)
        BEGIN
            INSERT INTO Categories(CategoryName, Description)
            VALUES (@categoryName, @description)
		END
        IF EXISTS (SELECT 1 FROM Categories WHERE CategoryName = @categoryName)
        BEGIN
            INSERT INTO Products(ProductName, UnitPrice, UnitsInStock, CategoryID)
            VALUES (@productName, @unitPrice, @unitsInStock, 
				(SELECT CategoryID FROM Categories WHERE CategoryName = @categoryName));
        END
    END TRY
    BEGIN CATCH
        PRINT 'There was an error: ' + ERROR_MESSAGE();
    END CATCH
END


EXECUTE sp_CheckCategoryAndAddProduct @categoryName = 'TestCategory2', 
@description = 'hdshhdj2', 
@productName = 'TestProduct3',
@unitPrice = 4,
@unitsInStock = 4