USE [master]
GO
/****** Object:  Database [DbDiff]    Script Date: 2020/3/24 21:27:16 ******/
CREATE DATABASE [DbDiff]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DbDiff', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DbDiff.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'DbDiff_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\DbDiff_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [DbDiff] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DbDiff].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DbDiff] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DbDiff] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DbDiff] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DbDiff] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DbDiff] SET ARITHABORT OFF 
GO
ALTER DATABASE [DbDiff] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DbDiff] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DbDiff] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DbDiff] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DbDiff] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DbDiff] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DbDiff] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DbDiff] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DbDiff] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DbDiff] SET  ENABLE_BROKER 
GO
ALTER DATABASE [DbDiff] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DbDiff] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DbDiff] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DbDiff] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DbDiff] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DbDiff] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DbDiff] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DbDiff] SET RECOVERY FULL 
GO
ALTER DATABASE [DbDiff] SET  MULTI_USER 
GO
ALTER DATABASE [DbDiff] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DbDiff] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DbDiff] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DbDiff] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DbDiff] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DbDiff', N'ON'
GO
ALTER DATABASE [DbDiff] SET QUERY_STORE = OFF
GO
USE [DbDiff]
GO
/****** Object:  Table [dbo].[DataAuditLog]    Script Date: 2020/3/24 21:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DataAuditLog](
	[LogId] [int] IDENTITY(1,1) NOT NULL,
	[LogType] [smallint] NOT NULL,
	[LogDate] [datetime] NOT NULL,
	[UserId] [int] NULL,
	[TableName] [nvarchar](50) NOT NULL,
	[RecordId] [nvarchar](50) NOT NULL,
	[FieldName] [nvarchar](50) NULL,
	[OldValue] [nvarchar](max) NULL,
	[NewValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_DataAuditLog] PRIMARY KEY CLUSTERED 
(
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Databases]    Script Date: 2020/3/24 21:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Databases](
	[DatabaseId] [uniqueidentifier] NOT NULL,
	[DatabaseName] [nvarchar](500) NOT NULL,
	[ConnectionString] [varchar](500) NOT NULL,
	[IsActive] [smallint] NOT NULL,
	[InsertUserId] [int] NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateUserId] [int] NULL,
	[UpdateDate] [datetime] NULL,
	[DeleteUserId] [int] NULL,
	[DeleteDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Exceptions]    Script Date: 2020/3/24 21:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Exceptions](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[GUID] [uniqueidentifier] NOT NULL,
	[ApplicationName] [nvarchar](50) NOT NULL,
	[MachineName] [nvarchar](50) NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[Type] [nvarchar](100) NOT NULL,
	[IsProtected] [bit] NOT NULL,
	[Host] [nvarchar](100) NULL,
	[Url] [nvarchar](500) NULL,
	[HTTPMethod] [nvarchar](10) NULL,
	[IPAddress] [nvarchar](40) NULL,
	[Source] [nvarchar](100) NULL,
	[Message] [nvarchar](1000) NULL,
	[Detail] [nvarchar](max) NULL,
	[StatusCode] [int] NULL,
	[SQL] [nvarchar](max) NULL,
	[DeletionDate] [datetime] NULL,
	[FullJson] [nvarchar](max) NULL,
	[ErrorHash] [int] NULL,
	[DuplicateCount] [int] NOT NULL,
 CONSTRAINT [PK_Exceptions] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Languages]    Script Date: 2020/3/24 21:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Languages](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[LanguageId] [nvarchar](10) NOT NULL,
	[LanguageName] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Languages] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RolePermissions]    Script Date: 2020/3/24 21:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RolePermissions](
	[RolePermissionId] [bigint] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NOT NULL,
	[PermissionKey] [nvarchar](100) NOT NULL,
 CONSTRAINT [PK_RolePermissions] PRIMARY KEY CLUSTERED 
(
	[RolePermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 2020/3/24 21:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
	[RoleKey] [nvarchar](100) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Table]    Script Date: 2020/3/24 21:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Table](
	[Id] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
	[DatabaseId] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Module] [nvarchar](500) NULL,
	[ObjectId] [varchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifyDate] [datetime] NOT NULL,
	[ColumnCount] [int] NOT NULL,
	[Description] [nvarchar](2000) NULL,
	[IsActive] [smallint] NOT NULL,
	[InsertUserId] [int] NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateUserId] [int] NULL,
	[UpdateDate] [datetime] NULL,
	[DeleteUserId] [int] NULL,
	[DeleteDate] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableColumn]    Script Date: 2020/3/24 21:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableColumn](
	[TableColumnId] [uniqueidentifier] NULL,
	[DatabaseId] [uniqueidentifier] NULL,
	[TableName] [nvarchar](500) NULL,
	[Name] [nvarchar](50) NULL,
	[Item] [int] NULL,
	[IsIdentity] [bit] NULL,
	[IsPk] [bit] NULL,
	[Type] [varchar](50) NULL,
	[OccupiedBytes] [int] NULL,
	[Length] [int] NULL,
	[DecimalPlaces] [int] NULL,
	[Isnullable] [bit] NULL,
	[DefaultValue] [nvarchar](500) NULL,
	[Description] [nvarchar](max) NULL,
	[IsActive] [smallint] NOT NULL,
	[InsertUserId] [int] NOT NULL,
	[InsertDate] [datetime] NOT NULL,
	[UpdateUserId] [int] NULL,
	[UpdateDate] [datetime] NULL,
	[DeleteUserId] [int] NULL,
	[DeleteDate] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TableComparison]    Script Date: 2020/3/24 21:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TableComparison](
	[Id] [uniqueidentifier] NULL,
	[TableName] [nvarchar](50) NULL,
	[FieldName] [nvarchar](50) NULL,
	[IsInFirst] [bit] NULL,
	[IsInSecond] [bit] NULL,
	[FirstIdentity] [bit] NULL,
	[FirstPrimary] [bit] NULL,
	[FirstFieldType] [varchar](50) NULL,
	[FirstAllowNull] [bit] NULL,
	[FirstDefaultValue] [nvarchar](500) NULL,
	[FirstDescription] [nvarchar](500) NULL,
	[SecondIdentity] [bit] NULL,
	[SecondPrimary] [bit] NULL,
	[SecondFieldType] [varchar](50) NULL,
	[SecondAllowNull] [bit] NULL,
	[SecondDefaultValue] [nvarchar](500) NULL,
	[SecondDescription] [nvarchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPermissions]    Script Date: 2020/3/24 21:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPermissions](
	[UserPermissionId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[PermissionKey] [nvarchar](100) NOT NULL,
	[Granted] [bit] NOT NULL,
 CONSTRAINT [PK_UserPermissions] PRIMARY KEY CLUSTERED 
(
	[UserPermissionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPreferences]    Script Date: 2020/3/24 21:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserPreferences](
	[UserPreferenceId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [bigint] NOT NULL,
	[PreferenceType] [nvarchar](100) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserPreferences] PRIMARY KEY CLUSTERED 
(
	[UserPreferenceId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 2020/3/24 21:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserRoleId] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserRoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2020/3/24 21:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](100) NOT NULL,
	[DisplayName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](100) NULL,
	[Source] [nvarchar](4) NOT NULL,
	[PasswordHash] [nvarchar](86) NOT NULL,
	[PasswordSalt] [nvarchar](10) NOT NULL,
	[LastDirectoryUpdate] [datetime] NULL,
	[UserImage] [nvarchar](100) NULL,
	[InsertDate] [datetime] NOT NULL,
	[InsertUserId] [int] NOT NULL,
	[UpdateDate] [datetime] NULL,
	[UpdateUserId] [int] NULL,
	[IsActive] [smallint] NOT NULL,
	[MobilePhoneNumber] [nvarchar](20) NULL,
	[MobilePhoneVerified] [bit] NOT NULL,
	[TwoFactorAuth] [int] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[VersionInfo]    Script Date: 2020/3/24 21:27:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VersionInfo](
	[Version] [bigint] NOT NULL,
	[AppliedOn] [datetime] NULL,
	[Description] [nvarchar](1024) NULL
) ON [PRIMARY]
GO
/****** Object:  Index [UC_Version]    Script Date: 2020/3/24 21:27:16 ******/
CREATE UNIQUE CLUSTERED INDEX [UC_Version] ON [dbo].[VersionInfo]
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Exceptions_App_Del_Cre]    Script Date: 2020/3/24 21:27:16 ******/
CREATE NONCLUSTERED INDEX [IX_Exceptions_App_Del_Cre] ON [dbo].[Exceptions]
(
	[ApplicationName] ASC,
	[DeletionDate] ASC,
	[CreationDate] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Exceptions_GUID_App_Del_Cre]    Script Date: 2020/3/24 21:27:16 ******/
CREATE NONCLUSTERED INDEX [IX_Exceptions_GUID_App_Del_Cre] ON [dbo].[Exceptions]
(
	[GUID] ASC,
	[ApplicationName] ASC,
	[DeletionDate] ASC,
	[CreationDate] DESC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_Exceptions_Hash_App_Cre_Del]    Script Date: 2020/3/24 21:27:16 ******/
CREATE NONCLUSTERED INDEX [IX_Exceptions_Hash_App_Cre_Del] ON [dbo].[Exceptions]
(
	[ErrorHash] ASC,
	[ApplicationName] ASC,
	[CreationDate] DESC,
	[DeletionDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_RolePerm_RoleId_PermKey]    Script Date: 2020/3/24 21:27:16 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_RolePerm_RoleId_PermKey] ON [dbo].[RolePermissions]
(
	[RoleId] ASC,
	[PermissionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_UserPerm_UserId_PermKey]    Script Date: 2020/3/24 21:27:16 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_UserPerm_UserId_PermKey] ON [dbo].[UserPermissions]
(
	[UserId] ASC,
	[PermissionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_UserPref_UID_PrefType_Name]    Script Date: 2020/3/24 21:27:16 ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_UserPref_UID_PrefType_Name] ON [dbo].[UserPreferences]
(
	[UserId] ASC,
	[PreferenceType] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_UserRoles_RoleId_UserId]    Script Date: 2020/3/24 21:27:16 ******/
CREATE NONCLUSTERED INDEX [IX_UserRoles_RoleId_UserId] ON [dbo].[UserRoles]
(
	[RoleId] ASC,
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_UserRoles_UserId_RoleId]    Script Date: 2020/3/24 21:27:16 ******/
CREATE UNIQUE NONCLUSTERED INDEX [UQ_UserRoles_UserId_RoleId] ON [dbo].[UserRoles]
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Exceptions] ADD  CONSTRAINT [DF_Exceptions_IsProtected]  DEFAULT ((1)) FOR [IsProtected]
GO
ALTER TABLE [dbo].[Exceptions] ADD  CONSTRAINT [DF_Exceptions_DuplicateCount]  DEFAULT ((1)) FOR [DuplicateCount]
GO
ALTER TABLE [dbo].[Table] ADD  CONSTRAINT [DF_Table_Id]  DEFAULT (newid()) FOR [Id]
GO
ALTER TABLE [dbo].[UserPermissions] ADD  CONSTRAINT [DF_UserPermissions_Granted]  DEFAULT ((1)) FOR [Granted]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_MobilePhoneVerified]  DEFAULT ((0)) FOR [MobilePhoneVerified]
GO
ALTER TABLE [dbo].[DataAuditLog]  WITH CHECK ADD  CONSTRAINT [FK_AuditLog_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[DataAuditLog] CHECK CONSTRAINT [FK_AuditLog_UserId]
GO
ALTER TABLE [dbo].[RolePermissions]  WITH CHECK ADD  CONSTRAINT [FK_RolePermissions_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[RolePermissions] CHECK CONSTRAINT [FK_RolePermissions_RoleId]
GO
ALTER TABLE [dbo].[UserPermissions]  WITH CHECK ADD  CONSTRAINT [FK_UserPermissions_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserPermissions] CHECK CONSTRAINT [FK_UserPermissions_UserId]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_RoleId]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([UserId])
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_UserId]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'8888888' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'DataAuditLog'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'wewe' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Databases', @level2type=N'COLUMN',@level2name=N'ConnectionString'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'rrrrr' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Databases'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exceptions', @level2type=N'COLUMN',@level2name=N'ApplicationName'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'we' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exceptions', @level2type=N'COLUMN',@level2name=N'CreationDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生成记录表' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Exceptions'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'eeeee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Languages', @level2type=N'COLUMN',@level2name=N'LanguageId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Table', @level2type=N'COLUMN',@level2name=N'DatabaseId'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'屏蔽类型对应值(类型对应Id)' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Table', @level2type=N'COLUMN',@level2name=N'Name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'wew' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Table', @level2type=N'COLUMN',@level2name=N'CreateDate'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'rr' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Table', @level2type=N'COLUMN',@level2name=N'ColumnCount'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ee' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'VersionInfo', @level2type=N'COLUMN',@level2name=N'AppliedOn'
GO
USE [master]
GO
ALTER DATABASE [DbDiff] SET  READ_WRITE 
GO
