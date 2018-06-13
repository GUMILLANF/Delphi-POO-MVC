CREATE DATABASE [Teste]

USE [Teste]
GO

CREATE TABLE [dbo].[Produtos](
	[Id] [int] NOT NULL,
	[Descricao] [nvarchar](50) NOT NULL,
	[Marca] [nvarchar](30) NULL,
	[UnidadeMedida] [nvarchar](3) NULL,
	[ValorVenda] [money] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


