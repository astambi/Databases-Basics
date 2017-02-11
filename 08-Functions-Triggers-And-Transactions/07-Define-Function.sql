CREATE FUNCTION ufn_IsWordComprised(@setOfLetters varchar(max), @word varchar(max))
RETURNS bit
AS
BEGIN
  DECLARE @isComprised bit = 0;
  DECLARE @currentIndex int = 1;
  DECLARE @currentChar char;

  WHILE(@currentIndex <= LEN(@word))
  BEGIN
    SET @currentChar = SUBSTRING(@word, @currentIndex, 1);
    IF(CHARINDEX(@currentChar, @setOfLetters) = 0)
      RETURN @isComprised;
    SET @currentIndex += 1;
  END
  RETURN @isComprised + 1;
END

--testing - do not Submit in Judge
CREATE TABLE TestDB (SetOfLetters varchar(max), Word varchar(max))
GO

INSERT INTO TestDB VALUES 
  ('oistmiahf', 'Sofia'), ('oistmiahf', 'halves'), ('bobr', 'Rob'), ('pppp', 'Guy'), ('', 'empty')
GO

SELECT SetOfLetters, Word,
  dbo.ufn_IsWordComprised(SetOfLetters, Word) AS Result
FROM TestDB