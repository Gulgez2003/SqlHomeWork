USE Northwind

CREATE PROCEDURE sp_CheckAndAddCategory
    @category NVARCHAR(15)
AS
BEGIN
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM Categories WHERE CategoryName = @category)
        BEGIN
            INSERT INTO Categories(CategoryName)
            VALUES (@category);
        END
        ELSE
        BEGIN
            PRINT 'This category exists in the database';
        END
    END TRY
    BEGIN CATCH
        PRINT 'There was an error: ' + ERROR_MESSAGE();
    END CATCH
END


EXECUTE sp_CheckAndAddCategory @category = 'Test'