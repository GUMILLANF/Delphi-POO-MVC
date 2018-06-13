object DmConexao: TDmConexao
  OldCreateOrder = False
  Height = 150
  Width = 215
  object sqlConexao_old: TSQLConnection
    ConnectionName = 'Teste'
    DriverName = 'MSSQL'
    LoadParamsOnConnect = True
    LoginPrompt = False
    Params.Strings = (
      'DriverName=MSSQL'
      'SchemaOverride=%.dbo'
      'DriverUnit=Data.DBXMSSQL'
      
        'DriverPackageLoader=TDBXDynalinkDriverLoader,DBXCommonDriver230.' +
        'bpl'
      
        'DriverAssemblyLoader=Borland.Data.TDBXDynalinkDriverLoader,Borla' +
        'nd.Data.DbxCommonDriver,Version=23.0.0.0,Culture=neutral,PublicK' +
        'eyToken=91d62ebb5b0d1b1b'
      
        'MetaDataPackageLoader=TDBXMsSqlMetaDataCommandFactory,DbxMSSQLDr' +
        'iver230.bpl'
      
        'MetaDataAssemblyLoader=Borland.Data.TDBXMsSqlMetaDataCommandFact' +
        'ory,Borland.Data.DbxMSSQLDriver,Version=23.0.0.0,Culture=neutral' +
        ',PublicKeyToken=91d62ebb5b0d1b1b'
      'LibraryName=dbxmss.dll'
      'VendorLib=sqlncli10.dll'
      'VendorLibWin64=sqlncli10.dll'
      'HostName=PC-GUSTAVO\SQLGUSTAVO'
      'Database=Teste'
      'MaxBlobSize=-1'
      'LocaleCode=0000'
      'IsolationLevel=ReadCommitted'
      'OSAuthentication=False'
      'PrepareSQL=True'
      'User_Name=sa'
      'Password=p@ssw0rd'
      'BlobSize=-1'
      'ErrorResourceFile='
      'OS Authentication=False'
      'Prepare SQL=False')
    Left = 80
    Top = 32
  end
  object sqlConexao: TFDConnection
    ConnectionName = 'Teste'
    Params.Strings = (
      'Database=Teste'
      'Server=PC-GUSTAVO\SQLGUSTAVO'
      'Password=p@ssw0rd'
      'ConnectionDef=MSSQL_Demo')
    Connected = True
    LoginPrompt = False
    Left = 72
    Top = 88
  end
end
