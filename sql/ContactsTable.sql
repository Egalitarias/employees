USE [Employees]
GO

ALTER TABLE [dbo].[Contacts] DROP CONSTRAINT [FK_Contacts_Employees]
GO

/****** Object:  Table [dbo].[Contacts]    Script Date: 3/04/2014 9:41:24 PM ******/
DROP TABLE [dbo].[Contacts]
GO

/****** Object:  Table [dbo].[Contacts]    Script Date: 3/04/2014 9:41:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Contacts](
	[ContactId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nchar](100) NULL,
	[Address] [nchar](100) NULL,
	[PhoneNo] [nchar](15) NULL,
	[MobileNo] [nchar](15) NULL,
	[EmployeeId] [int] NOT NULL,
 CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED 
(
	[ContactId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Contacts]  WITH CHECK ADD  CONSTRAINT [FK_Contacts_Employees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO

ALTER TABLE [dbo].[Contacts] CHECK CONSTRAINT [FK_Contacts_Employees]
GO
