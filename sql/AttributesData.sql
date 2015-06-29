USE Employees;

DELETE FROM Attributes;

INSERT INTO Attributes (AttributeId, Name, Value)
VALUES (1, 'Version', '1.0.0')

INSERT INTO Attributes (AttributeId, Name, Value)
VALUES (2, 'SMTPEmail', 'visagio.employee.records@gmail.com')

INSERT INTO Attributes (AttributeId, Name, Value)
VALUES (3, 'SMTPPassword', 'visagio2014')

INSERT INTO Attributes (AttributeId, Name, Value)
VALUES (4, 'SMTPHost', 'smtp.gmail.com')

INSERT INTO Attributes (AttributeId, Name, Value)
VALUES (5, 'SMTPPort', '587')

INSERT INTO Attributes (AttributeId, Name, Value)
VALUES (6, 'SMTPSubject', 'Visagio Person Details')




