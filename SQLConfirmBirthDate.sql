ALTER FUNCTION ConfirmBirthDate(@birthDate DATE, @age INT)
RETURNS VARCHAR(100)
AS
BEGIN
	DECLARE @result VARCHAR(100);
	--IF YEAR(GETDATE())-YEAR(@birthDate) = @age
	--BEGIN
		 IF @birthDate IS NULL
			BEGIN
				SET @result = 'Kişi henüz yıl, ay ve gün olarak yaşını doldurmamıştır'
			END
		ELSE IF DAY(@birthDate) IS NULL
			BEGIN
				SET @result = 'Yıl ve ay olarak doldurmuştur, gün olarak doldurmamıştır'
			END
		ELSE IF MONTH(@birthDate) IS NULL AND DAY(@birthDate) IS NULL
			BEGIN
				
				SET @result = 'Yıl olarak doldurmuştur, ay ve gün olarak doldurmamıştır'
			END
		--ELSE
		--	BEGIN
		--		SET @result = 'Kişi yıl, ay ve gün olarak yaşını doldurmuştur'
		--    END
    --END
	RETURN @result;
END

DECLARE @result VARCHAR(100);
DECLARE @birthYear VARCHAR(4);
DECLARE @birthMonth VARCHAR(2);
DECLARE @birthDay VARCHAR(2);
DECLARE @age INT;

SET @birthYear = 2003
SET @birthMonth = 06
SET @age = 21

SET @result = dbo.ConfirmBirthDate(DATEFROMPARTS(@birthYear,@birthMonth,@birthDay), @age)

SELECT @result AS Result
