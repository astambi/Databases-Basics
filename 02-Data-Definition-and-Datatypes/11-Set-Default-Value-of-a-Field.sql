ALTER TABLE Users
ADD CONSTRAINT DF_Users_LastLogin DEFAULT getdate() FOR LastLoginTime