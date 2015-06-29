USE [Employees]
GO

/****** Object:  Table [dbo].[Attributes]    Script Date: 20/04/2014 4:19:41 PM ******/
DROP TABLE [dbo].[Attributes]
GO

/****** Object:  Table [dbo].[Attributes]    Script Date: 20/04/2014 4:19:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Attributes](
	[AttributeId] [int] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Value] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Attributes] PRIMARY KEY CLUSTERED 
(
	[AttributeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


