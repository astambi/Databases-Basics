ALTER TABLE Users
ADD CONSTRAINT CK_Password CHECK (len(Password) >= 5)