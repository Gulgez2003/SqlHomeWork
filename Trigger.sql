USE Northwind

ALTER TRIGGER CUD_Trigger
ON Shippers
AFTER INSERT, DELETE, UPDATE
AS
BEGIN 
    IF EXISTS (SELECT 1 FROM inserted) AND NOT EXISTS (SELECT 1 FROM deleted)
    BEGIN
        PRINT 'Kayit Ekleme Islemi Yapildi.';
    END
    IF EXISTS (SELECT 1 FROM deleted) AND NOT EXISTS (SELECT 1 FROM inserted)
    BEGIN
        PRINT 'Silme Islemi Yapildi.';
    END
    IF EXISTS (SELECT 1 FROM inserted) AND EXISTS (SELECT 1 FROM deleted)
    BEGIN
        IF EXISTS (SELECT 1 FROM inserted ins INNER JOIN deleted del 
		ON ins.ShipperID = del.ShipperID 
		WHERE ins.CompanyName <> del.CompanyName AND ins.Phone <> del.Phone)
        BEGIN
            PRINT 'Guncelleme Islemi Yapildi.';
        END
    END
END;


INSERT INTO Shippers(CompanyName, Phone) VALUES('COMP', 'DESC')
UPDATE Shippers SET CompanyName = 'Test3' WHERE ShipperID = 1
DELETE FROM Shippers WHERE ShipperID = 4