USE [Employees]
GO

/****** Object:  Table [dbo].[Employees]    Script Date: 16/04/2014 9:37:33 PM ******/
DROP TABLE [dbo].[Employees]
GO

/****** Object:  Table [dbo].[Employees]    Script Date: 16/04/2014 9:37:33 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Employees](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[FamilyName] [nchar](100) NULL,
	[GivenName] [nchar](100) NULL,
	[DateOfBirth] [date] NULL,
	[Title] [nchar](20) NULL,
	[Address] [nchar](300) NULL,
	[Telephone] [nchar](10) NULL,
	[Mobile] [nchar](10) NULL,
	[Email] [nchar](100) NULL,
	[TaxFileNumber] [nchar](9) NULL,
	[CompanyName] [nchar](50) NULL,
	[AustralianBusinessNumber] [nchar](11) NULL,
	[BSBNumber] [nchar](6) NULL,
	[AccountNumber] [nchar](15) NULL,
	[BankName] [nchar](50) NULL,
	[BankBranch] [nchar](50) NULL,
	[AccountName] [nchar](100) NULL,
	[SuperFundName] [nchar](100) NULL,
	[MemberNumber] [nchar](20) NULL,
	[QantasFrequentFlyerNumber] [nchar](20) NULL,
	[VirginVelocityNumber] [nchar](20) NULL,
	[EmiratesSkywardsNumber] [nchar](20) NULL,
	[OthersNumber] [nchar](20) NULL,
 CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



