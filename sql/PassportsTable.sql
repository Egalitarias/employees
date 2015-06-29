USE [Employees]
GO

ALTER TABLE [dbo].[Passports] DROP CONSTRAINT [FK_Passports_Employees]
GO

/****** Object:  Table [dbo].[Passports]    Script Date: 16/04/2014 9:40:13 PM ******/
DROP TABLE [dbo].[Passports]
GO

/****** Object:  Table [dbo].[Passports]    Script Date: 16/04/2014 9:40:13 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Passports](
	[PassportId] [int] IDENTITY(1,1) NOT NULL,
	[PassportNumber] [nchar](20) NOT NULL,
	[Nationality] [nchar](50) NULL,
	[VisaType] [nchar](10) NULL,
	[VisaNumber] [nchar](20) NULL,
	[VisasIssueDate] [date] NULL,
	[VisasExpiryDate] [date] NULL,
	[EmployeeId] [int] NOT NULL,
 CONSTRAINT [PK_Passports] PRIMARY KEY CLUSTERED 
(
	[PassportId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Passports]  WITH CHECK ADD  CONSTRAINT [FK_Passports_Employees] FOREIGN KEY([EmployeeId])
REFERENCES [dbo].[Employees] ([EmployeeId])
GO

ALTER TABLE [dbo].[Passports] CHECK CONSTRAINT [FK_Passports_Employees]
GO



