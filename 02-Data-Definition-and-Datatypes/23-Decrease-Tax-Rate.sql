-- ALTER TABLE Payments
-- DROP CONSTRAINT CK_Payments_TaxAmount

-- ALTER TABLE Payments
-- DROP CONSTRAINT CK_Payments_PaymentTotal

UPDATE Payments
SET TaxRate *= 0.97

SELECT TaxRate FROM Payments

UPDATE Payments
SET TaxAmount = AmountCharged * TaxRate

UPDATE Payments
SET PaymentTotal = AmountCharged + TaxAmount

-- ALTER TABLE Payments
-- ADD CONSTRAINT CK_Payments_TaxAmount CHECK (TaxAmount = AmountCharged * TaxRate)

-- ALTER TABLE Payments
-- ADD CONSTRAINT CK_Payments_PaymentTotal CHECK (PaymentTotal = AmountCharged + TaxAmount)