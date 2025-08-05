object Database: TDatabase
  Height = 480
  Width = 640
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=escola'
      'User_Name=postgres'
      'Password=root'
      'Server=127.0.0.1'
      'DriverID=PG')
    Left = 80
    Top = 240
  end
  object FDPhysPgDriverLink: TFDPhysPgDriverLink
    VendorLib = '..\..\..\lib\libpq.dll'
    Left = 264
    Top = 248
  end
  object FDQuery: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'SELECT * FROM estudantes;')
    Left = 384
    Top = 272
  end
end
