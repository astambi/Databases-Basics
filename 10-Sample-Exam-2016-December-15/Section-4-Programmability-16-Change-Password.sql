CREATE PROCEDURE udp_ChangePassword (@email varchar(30), @newPassword varchar(20))
AS
BEGIN
  IF(@email NOT IN (SELECT Email FROM Credentials))
    RAISERROR('The email does''t exist!', 16, 1);
  ELSE 
    BEGIN
      UPDATE Credentials
      SET Password = @newPassword
      WHERE Email = @email
    END
END

GO
--testing
EXEC udp_ChangePassword 'abarnes0@sogou.com','new_pass';

SELECT * FROM Credentials WHERE Email = 'abarnes0@sogou.com';