ALTER TABLE Users
ADD CONSTRAINT CK_Users_Password CHECK (len(Password) >= 5)