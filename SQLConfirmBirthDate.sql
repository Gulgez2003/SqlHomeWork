ALTER FUNCTION ConfirmBirthDate(@birthDate DATE, @age INT)
RETURNS VARCHAR(100)
AS
BEGIN
    DECLARE @result VARCHAR(100);

    IF @birthDate IS NULL OR TRY_CAST(@birthDate AS DATE) IS NULL
        BEGIN
            SET @result = 'Unfortunately, the date of birth is incomplete or entered incorrectly'
        END
    ELSE 
	IF MONTH(@birthDate) IS NULL AND DAY(@birthDate) IS NULL
        BEGIN
            SET @result = 'Only the year is given'
        END
    ELSE IF DAY(@birthDate) IS NULL
        BEGIN
            SET @result = 'The year and month are given, but no day is given'
        END
    ELSE
        BEGIN
            SET @result = 'Date of birth completely filled in'
        END

    RETURN @result;
END

DECLARE @result VARCHAR(100);
DECLARE @birthDate DATE;
DECLARE @age INT;

SET @age = 21;
SET @birthDate = '2003-01-01'; 
SET @result = dbo.ConfirmBirthDate(@birthDate, @age);
SELECT @result AS Result;
