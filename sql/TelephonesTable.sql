USE [Employees]
GO

ALTER TABLE [dbo].[Telephones] DROP CONSTRAINT [FK_Telephones_Employees]
GO

/****** Object:  Table [dbo].[Telephones]    Script Date: 3/04/2014 9:45:28 PM ******/
DROP TABLE [dbo].[Telephones]
GO

/****** Object:  Table [dbo].[Telephones]    Script Date: 3/04/2014 9:45:28 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Telephones](
	[TelephoneId] [int] IDENTITY(1,1) NOT NULL,
	[Number] [nchar](15) NULL,
	[EmployeeId] [int] NOT NULL,
 CONSTRAINT [PK_Telephones] PRIMARY KEY CLUSTERED 
(
	[TelephoneId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Telephones]  WITH CHECK ADD  CONSTRAINT [FK_Telephones_Employees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO

ALTER TABLE [dbo].[Telephones] CHECK CONSTRAINT [FK_Telephones_Employees]
GO
